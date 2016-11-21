Sequel.migration do
  change do
    create_table :users do
      column :id, :uuid, default: :uuid_generate_v4.sql_function, primary_key: true
      column :created_at, :timestamptz, index: true, null: false
      column :updated_at, :timestamptz, index: true, null: false

      column :email, :text, index: true, null: false
      column :name, :text, null: false
      column :oauth_token, :text, null: false
      column :oauth_token_expires_at, :timestamptz
      column :profile_image_url, :text, null: false
      column :provider, :text, index: true, null: false
      column :uid, :text, index: true, null: false
    end
  end
end
