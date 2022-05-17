module CapybaraHelper
  def capybara_can_find_by(id)
    "id='#{id}'".html_safe if Rails.env.test?
  end
end