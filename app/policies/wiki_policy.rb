
class WikiPolicy < ApplicationPolicy
  class Scope < Scope
    attr_reader :user, :scope

    def resolve
      if user
        if user.role == "admin"
          scope.all.order(created_at: :desc)
        else
          scope = Wiki.is_public.or( Wiki.owned_by(user) )
          scope.order(created_at: :desc)
        end
      else
        scope = Wiki.is_public.order(created_at: :desc)
      end
    end

  end

  def update?
    (false if !user)
    if record.private?
      (record.collaborators.include?(user) ? true : false)
      (user.role == "admin" ? true : false)
    else
      true
    end
  end

  def show?
    (false if !user)
    if record.private?
      (record.collaborators.include?(user) ? true : false)
      (user.role == "admin" ? true : false)
    else
      true
    end
  end

  def destroy?
    if has_control_over?(record)
      true
    else
      raise Pundit::NotAuthorizedError, "You are not allowed to do that."
    end
  end

  def add_collaborator?
    has_control_over?(record) and not record.collaborators.include?(user)
  end

  def remove_collaborator?
    has_control_over?(record)
  end

  private
  def has_control_over?(wiki)
    user && ((user.role == "admin") || (user == wiki.user))
  end
end
