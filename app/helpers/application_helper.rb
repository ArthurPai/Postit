module ApplicationHelper

  def all_categories
    Category.all
  end

  def fix_url(url)
    url.start_with?('http://') ? url : "http://#{url}"
  end

  def custom_time_ago_in_words(time)
    difference_day = (Time.zone.now.to_date - time.to_date).to_i

    if difference_day >= 1
      "at #{time.strftime("%d %b %Y - %H:%M:%S %Z")}"
    else
      "#{time_ago_in_words(time)} ago"
    end
  end

  def display_datetime(dt)
    dt.strftime("%m/%d/%Y %l:%M%P %Z")
  end
end
