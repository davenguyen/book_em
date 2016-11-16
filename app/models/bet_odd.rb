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
  plugin :single_table_inheritance, :type

  many_to_one :game
  many_to_one :team

  def covered!
    return unless game.ended?
    update(covered: team_covered?)
  end

  def team_covered?
    return unless game.ended?
    team == team_covered
  end

  private

  def team_covered
    raise 'Inherit this model and implement'
  end
end
