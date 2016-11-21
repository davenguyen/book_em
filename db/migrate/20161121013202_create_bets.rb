Sequel.migration do
  change do
    create_table :bets do
      column :id, :uuid, default: :uuid_generate_v4.sql_function, primary_key: true
      column :created_at, :timestamptz, index: true, null: false

      foreign_key :user_id, :users, index: true, null: false, type: :uuid

      column :amount, 'numeric(12,2)', index: true, null: false
      column :payout, 'numeric(12,2)', index: true
      column :type, :text, index: true, null: false
    end
  end
end
