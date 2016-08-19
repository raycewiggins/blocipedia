class WikiPolicy < ApplicationPolicy
  def destroy?
    user.admin? || user.standard? || user.premium?
  end

  def update?
    user.admin? || user.standard? || user.premium?
  end

  class Scope
     attr_reader :user, :scope

     def initialize(user, scope)
       @user = user
       @scope = scope
     end

     def resolve
       wikis = []
       if user.role == 'admin'
         wikis = scope.all
       elsif user.role == 'premium'
         all_wikis = scope.all
         all_wikis.each do |wiki|
           #wiki must be 1. public, 2. have the user as collaborator, or 3. have the user as it's author to view it
           if !wiki.private? || wiki.users.include?(user) || wiki.user_id == user.id
             wikis << wiki
           end
         end
       else
         all_wikis = scope.all
         wikis = []
         all_wikis.each do |wiki|
           if !wiki.private? || wiki.users.include?(user)
             wikis << wiki
           end
         end
       end
       wikis
     end
   end
end
