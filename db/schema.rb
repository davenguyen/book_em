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
  end
end
              Sequel.migration do
                change do
                  self << "SET search_path TO \"$user\", public"
                  self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20161108051041_add_uuid_ossp.rb')"
self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20161108051042_add_citext.rb')"
self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20161108051837_create_sports.rb')"
                end
              end
