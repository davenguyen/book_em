class SpreadOdd < BetOdd
  private

  def favored_score
     @favored_score ||= game.home_team_score
  end

  def favored_team
     @favored_team ||= game.home_team
  end

  def score_difference
    @score_difference ||= favored_score + spread - unfavored_score
  end

  def switch_teams!
    @favored_score, @favored_team, @unfavored_score, @unfavored_team = [
      game.away_team_score,
      game.away_team,
      game.home_team_score,
      game.home_team
    ]
  end

  def team_covered
    switch_teams! if team == game.away_team
    if score_difference.zero?
      Team.tied
    else
      score_difference.positive? ? favored_team : unfavored_team
    end
  end

  def unfavored_score
     @unfavored_score ||= game.away_team_score
  end

  def unfavored_team
     @unfavored_team ||= game.away_team
  end
end
