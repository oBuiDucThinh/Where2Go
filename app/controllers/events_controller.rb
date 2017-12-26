class EventsController < ApplicationController
  before_action :logged_in_user, only: [:create, :new]
  before_action :find_user, only: [:show, :edit, :update]
  before_filter :require_permission, only: :edit
  def index
    @events = Event.all
  end

  def show
    @event_categories = @event.event_categories
    @event_owner = @event.user.name
    @comments = current_user.comments.build if logged_in?
  end

  def new
    @event = current_user.events.build
  end

  def create
    @event = current_user.events.build event_params
    @event.user = current_user

    if @event.save
      flash.now[:success] = t :event_created
      redirect_to @event
    else
      flash[:danger] = @event.errors.full_messages
      redirect_to new_event_path
    end
  end

  def edit
  end

  def update
    if @event.update_attributes event_params
      redirect_to @event
    else
      flash[:danger] = t :update_false
      render :edit
    end
  end

  def require_permission
    if current_user != Event.find_by(params[:id]).user
      redirect_to error_path
    end
  end

  private

  def find_user
    @event = Event.find_by id: params[:id]
  end

  def event_params
    params.require(:event).permit(:title, :content, :date_start, :date_end,
      :is_open, :picture, category_ids:[], city_ids:[])
  end
end
