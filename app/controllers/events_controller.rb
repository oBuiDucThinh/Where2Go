class EventsController < ApplicationController
  before_action :logged_in_user, only: [:create, :new]
  before_action :find_event, only: [:show, :edit, :update]
  before_filter :require_permission, only: :edit
  def index
    @filterrific = initialize_filterrific(
      Event,
      params[:filterrific],
      select_options: {
        sorted_by: Event.options_for_sorted_by,
        with_category_id: Category.options_for_select,
        with_city_id: City.options_for_select,
        sorted_by_date_start: Event.options_for_sorted_by
      },
      persistence_id: false,
      default_filter_params: {},
      available_filters: [:sorted_by, :sorted_by_date_start,
        :with_category_id, :with_city_id, :with_date_start_gte],
    ) or return

    @events = @filterrific.find.page(params[:page]).per(12)

    respond_to do |format|
      format.html
      format.js
    end

    rescue ActiveRecord::RecordNotFound => e
      puts "Had to reset filterrific params: #{ e.message }"
      redirect_to(reset_filterrific_url(format: :html)) and return
  end

  def show
    @event_categories = @event.event_categories
    @event_cities = @event.event_cities
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
    if logged_in?
      if current_user.id != Event.find_by(params[:id]).user_id
        redirect_to error_path
      end
    else
      redirect_to new_user_path
    end
  end

  private

  def find_event
    @event = Event.find_by id: params[:id]
  end

  def event_params
    params.require(:event).permit(:title, :content, :date_start, :date_end,
      :is_open, :picture, category_ids:[], city_ids:[])
  end
end
