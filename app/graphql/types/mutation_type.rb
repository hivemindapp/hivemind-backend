module Types
  class MutationType < Types::BaseObject
    field :create_comment, mutation: Mutations::Comments::CreateComment
  end
end
