Sequel.migration do
  change do
    create_table(:bet_odds_bets) do
      foreign_key :bet_odd_id, :bet_odds, null: false, type: :uuid
      foreign_key :bet_id, :bets, null: false, type: :uuid
      primary_key [:bet_odd_id, :bet_id]
      index [:bet_odd_id, :bet_id]
    end
  end
end
