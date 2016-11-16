Sequel.migration do
  change do
    create_table :bet_odds do
      column :id, :uuid, default: :uuid_generate_v4.sql_function, primary_key: true
      column :created_at, :timestamptz, index: true, null: false

      foreign_key :game_id, :games, index: true, null: false, type: :uuid
      foreign_key :team_id, :teams, index: true, null: false, type: :uuid

      column :covered, :boolean, index: true
      column :locks_at, :timestamptz
      column :odds, :integer, null: false
      column :spread, 'numeric(3, 1)', index: true
      column :type, :text, index: true, null: false
    end
  end
end
