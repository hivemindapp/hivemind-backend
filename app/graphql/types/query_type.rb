module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :posts,
          [Types::PostType],
          null: false,
          description: 'Returns a list of all posts'

    def posts
      Post.all
    end

    field :post,
          Types::PostType,
          null: false do
            argument :id, ID, required: true
          end

    def post(id:)
      Post.find(id)
    end

    field :comments,
          [Types::CommentType],
          null: false do
            argument :post_id, Integer, required: true
          end


    def comments(post_id:)
      Comment.joins(:post).where(post_id: post_id)
    end
  end
end
