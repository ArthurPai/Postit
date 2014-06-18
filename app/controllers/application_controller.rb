class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :current_user?, :logged_in?

  def customer
    if logged_in?
      flash[:error] = 'You also login!'
      redirect_to root_path
    end
  end

  def login_user
    unless logged_in?
      flash[:error] = 'You must login first!'
      redirect_to root_path
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_user?(user)
    current_user.id == user.id
  end

  def logged_in?
    !!current_user
  end
end
