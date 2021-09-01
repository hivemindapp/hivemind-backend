class Mutations::Users::CreateUser < ::Mutations::BaseMutation
  argument :username, String, required: true
  argument :region, String, required: false
  argument :biography, String, required: false
  argument :avatar, String, required: false

  type Types::UserType

  def resolve(username:, region:, biography:, avatar:)
    User.create!(username: username, region: region, biography: biography, avatar: avatar)
  end
end
