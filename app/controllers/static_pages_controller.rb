class StaticPagesController < ApplicationController
  def home
    @most_like_events = Event.most_like
    @most_join_events = Event.most_join
  end

  def contact
  end

  def help
  end

  def contact
  end

  def error
  end
end
