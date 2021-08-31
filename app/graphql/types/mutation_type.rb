module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::Users::CreateUser
    field :create_post, mutation: Mutations::Posts::CreatePost
<<<<<<< HEAD
    field :create_comment, mutation: Mutations::Comments::CreateComment
=======
    
    field :create_user, mutation: Mutations::Users::CreateUser
>>>>>>> create-user-endpoint
  end
end
