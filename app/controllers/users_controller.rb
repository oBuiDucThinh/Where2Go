class UsersController < ApplicationController
  def new
    @user = User.new
    @categories = Category.all
    @user.categories.build
  end

  def show
    @user = User.find_by id: params[:id]
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

  private

  def user_params
    params.require(:user).permit :name, :email, :phone, :role, :password, :password_confirmation,
      category_ids:[]
  end
end
