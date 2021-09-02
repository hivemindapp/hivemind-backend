class Mutations::Users::CreateUser < ::Mutations::BaseMutation
  argument :username, String, required: true
  argument :region, String, required: false
  argument :biography, String, required: false

  type Types::UserType

  def resolve(username:, region: nil, biography: nil)
    User.create!(username: username, region: region, biography: biography)
  end
end
