module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::Users::CreateUser
    field :create_post, mutation: Mutations::Posts::CreatePost
    field :create_comment, mutation: Mutations::Comments::CreateComment
  end
end
