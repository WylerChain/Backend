class AccountSerializer
  include Alba::Resource

  attributes :id, :email, :created_at, :updated_at

end
