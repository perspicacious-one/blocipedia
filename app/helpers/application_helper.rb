module ApplicationHelper
  include Devise::Controllers::Helpers
  def can_upgrade?
    current_user && current_user.role == "standard"
  end

  def has_control_over?(wiki)
    current_user && ((current_user.role == "admin") || (current_user == wiki.user))
  end
end
