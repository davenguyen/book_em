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
      foreign_key :league_id, :leagues, :type=>"uuid", :null=>false, :key=>[:id]
      column :abbreviation, "citext"
      column :city, "citext", :null=>false
      column :mascot, "citext", :null=>false
      
      primary_key [:id]
      
      index [:abbreviation]
      index [:city]
      index [:league_id]
      index [:mascot]
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
                end
              end
