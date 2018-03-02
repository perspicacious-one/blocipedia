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
    record.user == user or user.role == "admin" or not record.private?
  end

  def show?
    if  not user
      if not record.private?
        true
      else
        false
      end
    else
      record.user == user or user.role == "admin" or not record.private?
    end
  end

  def destroy?
    if user && (user.role == "admin")
      true
    else
      false
    end
  end
end
