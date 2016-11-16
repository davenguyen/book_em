# == Schema Info
#
# covered     :boolean   indexed
# created_at  :datetime  indexed      not null
# game_id     :uuid      indexed      not null
# id          :uuid      primary_key  not null, default(uuid_generate_v4())
# locks_at    :datetime
# odds        :integer                not null
# spread      :decimal   indexed
# team_id     :uuid      indexed      not null
# type        :string    indexed      not null
#

class BetOdd < Sequel::Model
  many_to_one :game
  many_to_one :team
end
