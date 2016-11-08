Sequel.migration do
  change do
    create_table :leagues do
      column :id, :uuid, default: :uuid_generate_v4.sql_function, primary_key: true

      foreign_key :sport_id, :sports, index: true, null: false, type: :uuid

      column :abbreviation, :citext, index: true, null: false
      column :name, :citext, index: true, null: false
    end
  end
end
