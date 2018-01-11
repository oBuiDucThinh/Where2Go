module StatisticsHelper
  def users_by_role
    column_chart @total_users.group(:role).count, height: "400px", library: {
      colors: ["#4267b2"],
      yAxis: {
        allowDecimals: false
      }
    }
  end

  def users_by_day
    line_chart @total_users.group_by_day(:created_at, format: "%B %d, %Y").count, height: "400px", library: {
      yAxis: {
        allowDecimals: false
      }
    }
  end

  def events_by_day
    line_chart @total_events.group_by_day(:created_at, format: "%b %y %a").count, height: "400px", library: {
      yAxis: {
        allowDecimals: false
      }
    }
  end

  def comments_by_day
    line_chart @total_comments.group_by_day(:created_at, format: "%b %y %a").count, height: "400px", library: {
      yAxis: {
        allowDecimals: false
      }
    }
  end

end
