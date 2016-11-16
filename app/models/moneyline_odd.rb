class MoneylineOdd < BetOdd
  private

  def team_covered
    if game.home_team_score > game.away_team_score
      game.home_team
    elsif game.away_team_score > game.home_team_score
      game.away_team
    else
      Team.tied
    end
  end
end
