class Admin::AdminEventsController < Admin::AdminController
  def index
    @event = Event.event_manage
  end

  def edit
    @event = Event.find_by id: params[:id]
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
  end
end
