class CollaboratorPolicy < ApplicationPolicy

  def create?
    if (user.publications.includes?(record.wiki) && record.user == current_user)
      raise Pundit::NotAuthorizedError, "You are already allowed to edit your Wiki."
    elsif not user.publications.includes?(resouce.wiki)
      raise Pundit::NotAuthorizedError, "You are not allowed to do that."
    else
      true
    end
  end
  def destroy?
    if user.publications.includes?(record.wiki)
      true
    else
      raise Pundit::NotAuthorizedError, "You are not allowed to do that."
    end
  end
end
