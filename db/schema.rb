Sequel.migration do
  change do
    create_table(:schema_migrations) do
      column :filename, "text", :null=>false
      
      primary_key [:filename]
    end
    
    create_table(:sports) do
      column :id, "uuid", :default=>Sequel::LiteralString.new("uuid_generate_v4()"), :null=>false
      column :name, "citext", :null=>false
      
      primary_key [:id]
      
      index [:name]
    end
    
    create_table(:leagues) do
      column :id, "uuid", :default=>Sequel::LiteralString.new("uuid_generate_v4()"), :null=>false
      foreign_key :sport_id, :sports, :type=>"uuid", :null=>false, :key=>[:id]
      column :abbreviation, "citext", :null=>false
      column :name, "citext", :null=>false
      
      primary_key [:id]
      
      index [:abbreviation]
      index [:name]
      index [:sport_id]
    end
    
    create_table(:teams) do
      column :id, "uuid", :default=>Sequel::LiteralString.new("uuid_generate_v4()"), :null=>false
      foreign_key :league_id, :leagues, :type=>"uuid", :key=>[:id]
      column :abbreviation, "citext"
      column :city, "citext", :null=>false
      column :mascot, "citext", :null=>false
      
      primary_key [:id]
      
      index [:abbreviation]
      index [:city]
      index [:league_id]
      index [:mascot]
    end
    
    create_table(:games) do
      column :id, "uuid", :default=>Sequel::LiteralString.new("uuid_generate_v4()"), :null=>false
      column :created_at, "timestamp with time zone", :null=>false
      column :updated_at, "timestamp with time zone", :null=>false
      foreign_key :away_team_id, :teams, :type=>"uuid", :null=>false, :key=>[:id]
      foreign_key :home_team_id, :teams, :type=>"uuid", :null=>false, :key=>[:id]
      column :away_team_score, "integer"
      column :home_team_score, "integer"
      column :starts_at, "timestamp with time zone"
      column :ends_at, "timestamp with time zone"
      
      primary_key [:id]
      
      index [:away_team_id]
      index [:created_at]
      index [:ends_at]
      index [:home_team_id]
      index [:starts_at]
      index [:updated_at]
    end
    
    create_table(:bet_odds) do
      column :id, "uuid", :default=>Sequel::LiteralString.new("uuid_generate_v4()"), :null=>false
      column :created_at, "timestamp with time zone", :null=>false
      foreign_key :game_id, :games, :type=>"uuid", :null=>false, :key=>[:id]
      foreign_key :team_id, :teams, :type=>"uuid", :null=>false, :key=>[:id]
      column :covered, "boolean"
      column :locks_at, "timestamp with time zone"
      column :odds, "integer", :null=>false
      column :spread, "numeric(3,1)"
      column :type, "text", :null=>false
      
      primary_key [:id]
      
      index [:covered]
      index [:created_at]
      index [:game_id]
      index [:spread]
      index [:team_id]
      index [:type]
    end
  end
end
              Sequel.migration do
                change do
                  self << "SET search_path TO \"$user\", public"
                  self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20161108051041_add_uuid_ossp.rb')"
self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20161108051042_add_citext.rb')"
self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20161108051837_create_sports.rb')"
self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20161108052206_create_leagues.rb')"
self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20161108053420_create_teams.rb')"
self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20161108053846_create_games.rb')"
self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20161113105821_create_bet_odds.rb')"
                end
              end
