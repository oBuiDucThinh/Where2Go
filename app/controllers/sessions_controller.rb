class SessionsController < Devise::SessionsController
  before_action :set_root_path

  def new
    super
  end

  def create
    super
  end

  def destroy
    super
  end

  private

  def set_root_path
    @referer_url = root_path
  end

  def load_after_sign_in_path_for resource
    sign_in_url = url_for(action: :new, controller: "sessions", only_path: false, protocol: "http")
    if @referer_url == sign_in_url
      super
    else
      @referer_url || root_path
    end
  end
end
