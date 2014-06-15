module ApplicationHelper

  def all_categories
    Category.all
  end

  def fix_url(url)
    url.start_with?('http://') ? url : "http://#{url}"
  end

  def custom_time_ago_in_words(time)
    "#{time_ago_in_words(time)} ago"
  end

  def display_datetime(dt)
    dt.strftime("%m/%d/%Y %l:%M%P %Z")
  end
end
