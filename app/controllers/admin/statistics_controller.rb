class  Admin::StatisticsController <  Admin::AdminController
  before_action :verify_admin

  def index
    @total_users = User.all
    @total_events = Event.all
    @new_users = User.new_user_this_month
    @total_comments = Comment.all
  end

  private

  def verify_admin
    redirect_to root_url unless admin_user?
  end

end
