class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      flash[:notice] = "Welcome back #{user.username}"
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:errors] = 'There were some errors of your username or password!'
      redirect_to login_path
    end
  end

  def destroy
    flash[:notice] = "See you, #{current_user.username}"
    session[:user_id] = nil
    redirect_to root_path
  end
end