module Types
  class PostType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :description, String, null: false
    field :image_urls, [String], null: true
    field :upvotes, Integer, null: true
    field :downvotes, Integer, null: true
    field :user_id, Integer, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :user, Types::UserType, null: false
    field :comments, [Types::CommentType], null: true

    def image_urls
      post.images.map do |image|
        require 'pry'; binding.pry
        Rails.application.routes.url_helpers.rails_blob_url(image)
      end
    end
  end
end
