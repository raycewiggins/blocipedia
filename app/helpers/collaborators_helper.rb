module CollaboratorsHelper
  def users_to_buttons(users)
      raw users.map { |l| link_to l.email, collaborator_path(id: l.id), class: 'btn-xs btn-default' }.join(' ')
  end
end
