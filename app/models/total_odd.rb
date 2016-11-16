class TotalOdd < BetOdd
  alias_method :total, :spread

  private

  def game_total
    @game_total ||= game.home_team_score + game.away_team_score
  end

  def team_covered
    if total > game_total
      Team.over
    elsif total < game_total
      Team.under
    else
      Team.tied
    end
  end
end
