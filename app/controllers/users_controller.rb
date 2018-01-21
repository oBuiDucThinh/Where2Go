class UsersController < ApplicationController
  before_action :correct_user, :get_user_by_id,
    only: [:edit, :update]

  def new
    @user = User.new
  end

  def show
    @user = current_user
    @like_event = @user.like_events
    @join_event = @user.join_events
    @created_event = @user.events
    return if @user
    flash[:danger] = t :user_nil
    redirect_to signup_path
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:info] = t :acc_activate
      redirect_to root_url
    else
      flash[:info] = "You failed"
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes edit_user_params
      flash[:success] = t ".profile_updated"
      redirect_to new_user_session_path
    else
      render :edit
    end
  end

  private

  def correct_user
    get_user_by_id
    redirect_to root_url unless current_user? @user
  end

  def user_params
    params.require(:user).permit :name, :email, :phone, :role, :password,
      :password_confirmation
  end

  def edit_user_params
    params.require(:user).permit :name, :email, :phone, :password,
      :password_confirmation, :picture
  end

  def get_user_by_id
    @user = User.find_by id: params[:id]
  end

end
