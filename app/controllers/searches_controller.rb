class SearchesController < ApplicationController
  def search
    @events = Event.search(params[:term]).order_by_title
    render json:@events.map {|event| event.title}
  end

  def index
    @events = Event.search(params[:term]).order_by_title
  end
end
