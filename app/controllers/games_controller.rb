class GamesController < ApplicationController
  def index
  end

  private

  def upcoming_games
    @upcoming_games ||= Game.upcoming.all
  end
  helper_method :upcoming_games
end
