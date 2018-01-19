class SearchesController < ApplicationController
  def search
    @events_search = Event.search(params[:term]).order_by_title
    render json:@events.map {|event| event.title}
  end

  def index
    @events_search = Event.search(params[:term]).order_by_title
  end
end
