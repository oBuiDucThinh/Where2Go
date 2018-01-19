class EventsController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :find_event, only: [:show, :edit, :update]
  before_filter :require_permission, only: :edit

  def index
    @events_close = Event.load_event_close.ordered_by_date_created.limit(4)
    @events_open = Event.load_event_open.ordered_by_date_created.limit(4)
    @events_coming = Event.load_event_coming.ordered_by_date_created.limit(4)
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

  def search
    @q = Event.ransack params[:q]
    @events_search = @q.result(distinct: true).page params[:page]
    respond_to do |format|
      format.html
      format.json {render json: @events_search}
    end
    render :search
  end

  def show
    @event_categories = @event.event_categories
    @event_cities = @event.event_cities
    @event_owner = @event.user.name
    @event_owner_id = @event.user.id
    @comments = current_user.comments.build if user_signed_in?
    if request.xhr?
      render json: {
        latitude: @event.latitude,
        longitude: @event.longitude
      }
    end
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
    if user_signed_in?
      if current_user != Event.find_by(params[:id]).user
        redirect_to error_path
      end
    else
      redirect_to new_user_path
    end
  end

  private

  def find_event
    @event = Event.find_by id: params[:id]
    if @event.nil?
      flash[:danger] = t :error
      redirect_to root_url
    end
  end

  def event_params
    params.require(:event).permit(:title, :content, :date_start, :date_end,
      :is_open, :address, :picture, category_ids:[], city_ids:[])
  end
end
