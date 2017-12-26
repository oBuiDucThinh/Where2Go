class UsersController < ApplicationController
  def new
    @user = User.new
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

  private

  def user_params
    params.require(:user).permit :name, :email, :phone, :role, :password, :password_confirmation,
      category_ids:[]
  end
end
