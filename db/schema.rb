Sequel.migration do
  change do
    create_table(:schema_migrations) do
      column :filename, "text", :null=>false
      
      primary_key [:filename]
    end
  end
end
              Sequel.migration do
                change do
                  self << "SET search_path TO \"$user\", public"
                  self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20161108051041_add_uuid_ossp.rb')"
self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20161108051042_add_citext.rb')"
                end
              end