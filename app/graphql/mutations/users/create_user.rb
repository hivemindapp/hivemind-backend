class Mutations::Users::CreateUser < ::Mutations::BaseMutation
  argument :username, String, required: true
  argument :region, String, required: true
  argument :biography, String, required: true
  argument :avatar, String, required: true

  type Types::UserType

  def resolve(username:, region:, biography:, avatar:)
    User.create!(username: username, region: region, biography: biography, avatar: avatar)
  end
end
