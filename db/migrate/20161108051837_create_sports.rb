Sequel.migration do
  change do
    create_table :sports do
      column :id, :uuid, default: :uuid_generate_v4.sql_function, primary_key: true

      column :name, :citext, index: true, null: false
    end
  end
end
