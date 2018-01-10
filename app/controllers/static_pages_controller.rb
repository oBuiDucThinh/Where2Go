class StaticPagesController < ApplicationController
  def home
    @events = Event.ordered_by_date_created.limit Settings.static_pages.limitation.maximum
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
