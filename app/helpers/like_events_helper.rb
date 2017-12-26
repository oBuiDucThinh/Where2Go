module LikeEventsHelper
  def like? event
    current_user.like_events.find_by event_id: event
  end

  def join? event
    current_user.join_events.find_by event_id: event
  end
end
