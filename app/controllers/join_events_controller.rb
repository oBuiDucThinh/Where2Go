class JoinEventsController < ApplicationController
  before_action :logged_in?, only: [:create]
  def create
    @user = current_user.id
    @event = params[:event_id]
    @current_event = Event.find_by id: @event
    join = {user_id: @user, event_id: @event}
    @new_join = JoinEvent.new join

    if @new_join.save
      @temp = true
    else
      @current_join = JoinEvent.find_by(user_id: @user, event_id: @event)
      @current_join.destroy
      @temp = false
    end
    return @temp

    respond_to do |format|
      format.html {redirect_to events_path}
      format.js
    end
  end

  private

  def logged_in?
    return if current_user.present?
    redirect_to new_user_path
  end
end
