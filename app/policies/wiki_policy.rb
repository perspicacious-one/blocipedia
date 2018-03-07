class WikiPolicy < ApplicationPolicy
  class Scope < Scope
    attr_reader :user, :scope

    def resolve
      if user
        if user.role == "admin"
          scope.all.order(created_at: :desc)
        else
          scope = Wiki.is_public.or( Wiki.owned_by(user) ).or( Wiki.collaborates_on(user) )
          scope.order(created_at: :desc)
        end
      else
        scope = Wiki.is_public.order(created_at: :desc)
      end
    end

  end

  def update?
    record.user == user or user.role == "admin" or not record.private?
  end

  def show?
    if !user
      if !record.private?
        true
      else
        raise Pundit::NotAuthorizedError, "You are not allowed to do that."
        redirect_to root_path
      end
    else
      record.user == user or user.role == "admin" or not record.private?
    end
  end

  def destroy?
    if user && (user.role == "admin")
      true
    else
      raise Pundit::NotAuthorizedError, "You are not allowed to do that."
    end
  end
end
