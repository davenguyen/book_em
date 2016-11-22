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

  one_to_many :bet_odds

  %w(moneyline spread total).each do |odd_type|
    %w(away home).each do |team|
      one_to_one  :"#{odd_type}_bet_#{team}",
        class: :"#{odd_type.capitalize}Odd",
        key: [:game_id, :team_id],
        primary_key: [:id, :"#{team}_team_id"] do |ds|
          ds.where{locks_at > Time.now}
        end
    end
  end

  dataset_module do
    def upcoming
      where{starts_at > Time.now}.
        where{starts_at <= (Time.now + 24.hours)}.
        order(:starts_at)
    end
  end

  def ended?
    return nil unless ends_at.present?
    Time.now >= ends_at
  end
end
