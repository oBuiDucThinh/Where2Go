class EventsController < ApplicationController
  before_action :logged_in_user, only: [:create, :new]
  def index
  end

  def show
    @event = Event.find_by id: params[:id]
    @event_owner = @event.user.name
  end

  def new
    @event = current_user.events.build
  end

  def create
    @event = current_user.events.build event_params
    @event.user = current_user

    if @event.save
      flash.now[:success] = "Event Created"
      redirect_to @event
    else
      flash[:danger] = @event.errors.full_messages
      redirect_to new_event_path
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :content, :date_start, :date_end,
      :is_open, category_ids:[], city_ids:[])
  end
end
