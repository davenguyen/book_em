class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def current_user
    @current_user ||= User[session[:user_id]]
  end
  helper_method :current_user

  def leagues
    @leagues ||= League.order(:abbreviation).all
  end
  helper_method :leagues
end
