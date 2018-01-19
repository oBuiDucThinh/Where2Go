class Admin::EventsController < Admin::AdminController
  before_action :find_event, only: [:update, :destroy, :edit]
  def index
    @event = Event.event_manage
  end

  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    if @event.update_attributes event_params
      respond_to do |format|
        format.html {redirect_to admin_events_path}
        format.js
      end
    else
      flash.now[:danger] = t "Updated false"
    end
  end

  def destroy
    if @event.destroy
      flash[:success] = "Deleted event"
      redirect_to admin_events_path
    else
      flash[:false] = "Not deleted"
    end
  end

  private

  def find_event
    @event = Event.find_by id: params[:id]
  end

  def event_params
    params.require(:event).permit(:title, :content, :date_start, :date_end,
      :is_open, :address, :picture, category_ids:[], city_ids:[])
  end
end
