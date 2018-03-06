module ApplicationHelper
  def can_upgrade?
    current_user && current_user.role == "standard"
  end
end
