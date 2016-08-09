class WikiPolicy < ApplicationPolicy
  def destroy?
    user.admin? || user.standard? || user.premium?
  end

  def update?
    user.admin? || user.standard? || user.premium?
  end
end
