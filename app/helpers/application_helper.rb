module ApplicationHelper

  def all_categories
    Category.all
  end

  def fix_url(url)
    url.start_with?('http://') ? url : "http://#{url}"
  end
end
