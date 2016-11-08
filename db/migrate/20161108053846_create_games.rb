Sequel.migration do
  change do
    create_table :games do
      column :id, :uuid, default: :uuid_generate_v4.sql_function, primary_key: true
      column :created_at, :timestamptz, index: true, null: false
      column :updated_at, :timestamptz, index: true, null: false

      foreign_key :away_team_id, :teams, index: true, null: false, type: :uuid
      foreign_key :home_team_id, :teams, index: true, null: false, type: :uuid

      column :away_team_score, :integer
      column :home_team_score, :integer
      column :starts_at, :timestamptz, index: true
      column :ends_at, :timestamptz, index: true
    end
  end
end
