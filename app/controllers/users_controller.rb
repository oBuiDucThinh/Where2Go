class UsersController < ApplicationController
  before_action :correct_user,   only: [:index]
  
  def new
    @user = User.new
    @categories = Category.all
    @user.categories.build
  end

  def show
    @user = User.find_by id: params[:id]
    
    if @user.nil?
      flash[:error] = t".no_user"
    end
  end

  def index
    @users = User.all
  end

  def edit
    @user = User.find_by id: params[:id]
    @categories = Category.all
    @user.categories.build
  end

  def create
    @user = User.new user_params

    if @user.save
      flash[:info] = t :acc_activate
      redirect_to root_url
    else
      render :new
    end
  end

  def update
    @user = User.find_by id: params[:id]
    @categories = Category.all
    @user.categories.build

    if @user.update_attributes user_params
      flash[:success] = t".profile_updated"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def logged_in_user
    unless logged_in?
      flash[:danger] = :please_login
      redirect_to login_url
    end
  end

  def correct_user
    redirect_to(root_url) unless admin_user?
  end

  def user_params
    params.require(:user).permit :name, :email, :phone, :role, :password,
      :password_confirmation, category_ids:[]
  end
end
