# == Schema Info
#
# away_team_id     :uuid      indexed      not null
# away_team_score  :integer
# created_at       :datetime  indexed      not null
# ends_at          :datetime  indexed
# home_team_id     :uuid      indexed      not null
# home_team_score  :integer
# id               :uuid      primary_key  not null, default(uuid_generate_v4())
# starts_at        :datetime  indexed
# updated_at       :datetime  indexed      not null
#

class Game < Sequel::Model
  many_to_one :away_team, class: :Team
  many_to_one :home_team, class: :Team
end
