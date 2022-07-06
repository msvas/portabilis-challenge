# Parses user data when responding with a JSON
class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :role
end
