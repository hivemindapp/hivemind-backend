class Mutations::Users::CreateUser < Mutations::BaseMutation
  argument :username, required: true
  argument :region, required: true
  argument :biography, required: true
  argument :avatar, required: true

  type Types::UserType

  def resolver(username:, region:, biography:, avatar:)
    User.create!(username: username, region: region, biography: biography, avatar: avatar)
  end
end
