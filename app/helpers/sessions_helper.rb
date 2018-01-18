module SessionsHelper
  def is_creator?
    return current_user.creator?
  end
end
