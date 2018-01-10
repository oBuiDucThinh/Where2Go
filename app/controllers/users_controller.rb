class UsersController < ApplicationController
  before_action :logged_in_user, :correct_user, :get_user_by_id,
    only: [:edit, :update]
  
  def new
    @user = User.new
    @categories = Category.all
    @user.categories.build
  end

  def show
    @user = current_user
    @events_join = @user.user_events.where(join:true)
    @events_like = @user.user_events.where(like:true)
    @events_created = @user.events
    return if @user
    flash[:danger] = t :user_nil
    redirect_to signup_path
  end

  def create
    @user = User.new user_params
    @categories = Category.all
    if @user.save
      flash[:info] = t :acc_activate
      redirect_to root_url
    else
      flash[:info] = "You failed"
      render :new
    end
  end

  def edit
    @categories = Category.user_edit_subscribe
    @user.categories.build
  end

  def update
    @categories = Category.user_edit_subscribe
    @user.categories.build

    if @user.update_attributes edit_user_params
      flash[:success] = t ".profile_updated"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = :please_login
      redirect_to login_url
    end
  end

  def correct_user
    get_user_by_id
    redirect_to root_url unless current_user? @user
  end
  
  def user_params
    params.require(:user).permit :name, :email, :phone, :role, :password,
      :password_confirmation, category_ids:[]
  end

  def edit_user_params
    params.require(:user).permit :name, :email, :phone, :password,
      :password_confirmation, category_ids:[]
  end

  def get_user_by_id
    @user = User.find_by id: params[:id]
  end

end
