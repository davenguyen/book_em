Sequel.migration do
  change do
    create_table :teams do
      column :id, :uuid, default: :uuid_generate_v4.sql_function, primary_key: true

      foreign_key :league_id, :leagues, index: true, null: false, type: :uuid

      column :abbreviation, :citext, index: true
      column :city, :citext, index: true, null: false
      column :mascot, :citext, index: true, null: false
    end
  end
end
