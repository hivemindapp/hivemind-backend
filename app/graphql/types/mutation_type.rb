module Types
  class MutationType < Types::BaseObject
    field :create_post, mutation: Mutations::Posts::CreatePost
    field :create_comment, mutation: Mutations::Comments::CreateComment
    field :create_user, mutation: Mutations::Users::CreateUser
  end
end
