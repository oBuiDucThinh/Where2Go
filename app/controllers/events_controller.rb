class EventsController < ApplicationController
  def index
  end

  def show
    @event = Event.find_by id: params[:id]
    return if @event
    redirect_to root_path
  end
end
