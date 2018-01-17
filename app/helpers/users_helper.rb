module UsersHelper
  def gravatar_for user, size: Settings.users_helper.size
    gravatar_id = Digest::MD5::hexdigest user.email.downcase
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag gravatar_url, alt: user.name, class: "gravatar"
  end

  def current_user? user
    user == current_user
  end

  def admin_user?
    current_user.admin?
  end

  def verify_admin
    redirect_to root_url unless admin_user?
  end

end
