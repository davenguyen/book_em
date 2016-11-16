class Annotator
  DB = Sequel::Model.db
  MODELS_PATH = Rails.root.join('app', 'models')

  class << self
    def annotate
      models_updated = []
      table_names = DB.tables.map(&:to_s)
      table_names.each do |table_name|
        begin
          schema = Schema.new(table_name)
          schema.commit!
          models_updated << table_name
        rescue ModelError, SchemaError
          next
        end
      end

      models_updated.empty? ?
        'Nothing updated' :
        "Models updated: #{models_updated.join(', ')}"
    end
  end

  class Schema
    HEADER = '# == Schema Info'

    def initialize(table)
      @file = MODELS_PATH.join("#{table.singularize}.rb")
      raise ModelError unless File.exist? @file

      @content = File.read(@file)

      indexes = DB.indexes(table).flat_map { |k, v| v[:columns] if !v[:unique] }.compact
      uniques = DB.indexes(table).flat_map { |k, v| v[:columns] if v[:unique] && v[:columns].count < 2 }.compact

      db_columns = DB.schema(table)
      @columns = db_columns.sort.map do |column|
        column.second[:indexed] = indexes.include? column.first
        column.second[:unique] = uniques.include? column.first
        ColumnInfo.new(column)
      end
      @name_size = db_columns.map { |c| c.first.size }.max
      @type_size = db_columns
        .map { |c| (c.last[:type] || c.last[:db_type]).size }
        .max
      @index_size = db_columns
        .inject([]) do |a, c|
            a << case
                 when c.last[:primary_key]
                   'primary_key'
                 when c.last[:unique]
                   'unique'
                 when c.last[:indexed]
                   'indexed'
                 else
                   ''
                 end.size
          end
        .max

      @new_content = new_content
    end

    def new_content
      if @content.starts_with? '#'
        if (insert_at = @content.lines.index "#{HEADER}\n")
          @content.gsub(/^#{HEADER}.*?\n\n/m, "\n")
            .lines.insert(insert_at, schema_output).join
        else
          # Insert the schema info after the last commented line
          @content.lines.each_with_index do |line, i|
            next if line.starts_with? '#'
            insert_at = i
            break
          end
          @content.lines.insert(insert_at || 0, "#\n" << schema_output).join
        end
      else
        schema_output << "\n" << @content
      end
    end

    def schema_output
      <<-SCHEMA
#{HEADER}
#
#{@columns.map { |column| column.output(@name_size, @type_size, @index_size) }.join("\n")}
#
      SCHEMA
    end

    def commit!
      raise SchemaError unless @content != @new_content
      File.open(@file, 'wb') { |f| f.puts @new_content }
      true
    end
  end

  class ColumnInfo
    def initialize(column)
      @column = column
    end

    def output(name_size, type_size, index_size)
      "# #{name.ljust(name_size)}  :#{type.ljust(type_size)}  #{index.ljust(index_size)}  #{options}".strip
    end

    private

    def allow_null
      opts.fetch(:allow_null)
    end

    def default
      opts.fetch(:default)
    end

    def indexed?
      !!opts.fetch(:indexed)
    end

    def name
      @column.first.to_s
    end

    def index
      return 'primary_key' if primary_key?
      return 'unique' if unique?
      return 'indexed' if indexed?
      ''
    end

    def options
      options = []
      options.push('not null') if !allow_null
      options.push("default(#{default})") if default.present?
      options.join(', ')
    end

    def opts
      @column.last
    end

    def primary_key?
      opts.fetch(:primary_key)
    end

    def type
      (opts.fetch(:type) || opts.fetch(:db_type)).to_s
    end

    def unique?
      !!opts.fetch(:unique)
    end
  end

  class ModelError < StandardError
    def initialize(msg = 'Nonexistent file')
      super
    end
  end

  class SchemaError < StandardError
    def initialize(msg = 'Schema unchanged')
      super
    end
  end
end
