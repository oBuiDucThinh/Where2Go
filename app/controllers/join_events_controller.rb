class JoinEventsController < ApplicationController
  before_action :logged_in?, only: [:create]
  def create
    @user_id = current_user.id
    @event_id = params[:event_id]
    @current_event = Event.find_by id: @event_id
    @new_join = JoinEvent.new user_id: @user_id, event_id: @event_id

    if @new_join.save
      @temp = true
    else
      @current_join = JoinEvent.find_by user_id: @user_id, event_id: @event_id
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
    redirect_to new_user_session_path
  end
end
