class Admin::EventsController < Admin::AdminController
  before_action :verify_admin
  before_action :load_event, except: :index
  before_action :load_creator, :load_location, :load_category,
    only: [:show]

  def index
    @events = Event.load_for_admin_index_order_by_date.page(params[:page])
      .per(Settings.show_limit.show_10)
  end

  def show
  end

  def edit
  end

  def update
    if @event.update_attributes event_open_params
      redirect_to admin_events_url
    else
      flash[:danger] = t :update_false
      render :edit
    end
  end

  def destroy
    if @event.destroy
      flash[:success] = t ".event_deleted"
    else
      flash[:error] = t ".error"
    end
    redirect_to admin_events_url
  end

  private

  def load_event
    @event = Event.find_by id: params[:id]

    if @event.nil?
      flash[:error] = t ".error"
    end
  end

  def load_creator
    @creator = @event.user

    if @creator.nil?
      @creator_name = :na
    else
      @creator_name = @creator.name
    end
  end

  def load_category
    @event_categories = @event.event_categories
  end

  def load_location
    @locations = @event.event_cities
  end

  def event_open_params
    params.require(:event).permit(:id, :is_open)
  end

  def event_params
    params.require(:event).permit(:title, :content, :date_start, :date_end,
      :is_open, :picture, category_ids:[], city_ids:[])
  end

end
