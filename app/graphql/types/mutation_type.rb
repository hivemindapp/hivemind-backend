module Types
  class MutationType < Types::BaseObject
    field :create_post, mutation: Mutations::Posts::CreatePost
<<<<<<< HEAD
    field :create_comment, mutation: Mutations::Comments::CreateComment
=======
>>>>>>> b7a9043 (Impliment create comment mutation)
    field :create_user, mutation: Mutations::Users::CreateUser
    field :create_comment, mutation: Mutations::Comments::CreateComment
  end
end
