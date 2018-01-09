class Admin::UsersController < Admin::AdminController
  before_action :verify_admin
  before_action :load_user, except: :index

  def show
  end

  def index
    @users = User.load_to_show_ordered_by_name.page(params[:page])
      .per(Settings.show_limit.show_10)
  end

  def edit
  end

  def update
    @user.skip_password_validation = true

    if @user.update_attributes update_user_params
      flash[:success] = t ".profile_updated"
      redirect_to admin_user_path
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".user_deleted"
    else
      flash[:error] = t ".error"
    end
    redirect_to admin_users_url
  end

  private

  def update_user_params
    params.require(:user).permit :role
  end

  def verify_admin
    redirect_to root_url unless admin_user?
  end

  def load_user
    @user = User.find_by id: params[:id]

    if @user.nil?
      flash[:error] = t ".no_user"
    end
  end

end
