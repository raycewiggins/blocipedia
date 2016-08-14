module UsersHelper
  def users_to_buttons(users)
      raw users.map { |l| link_to l.email, user_path(id: l.id), class: 'btn-xs btn-primary' }.join(' ')
  end
end
