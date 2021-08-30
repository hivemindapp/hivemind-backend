module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :post,
          Types::PostType,
          null: false do
            argument :id, ID, required: true
          end

    field :posts,
          [Types::PostType],
          null: false,
          description: 'Returns a list of all posts'

    field :user_posts, [Types::PostType], null: false, description: 'Returns a list of specific user posts' do
      argument :user_id, ID, required: true
    end

    field :post_comments, [Types::CommentType], null: false, description: 'Returns a list of specific posts comments' do
      argument :post_id, ID, required: true
    end

    def post(id:)
      Post.find(id)
    end

    def posts
      Post.all
    end

    def user_posts(user_id:)
      User.find(user_id).posts
    end

    def post_comments(post_id:)
      Post.find(post_id).comments
    end
  end
end
