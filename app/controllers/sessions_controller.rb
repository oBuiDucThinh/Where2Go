class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by email: params[:session][:email].downcase

    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == "Settings.sessions.remember" ? remember(user) : forget(user)
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end
end
