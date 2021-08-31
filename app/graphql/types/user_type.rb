module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :username, String, null: false
    field :region, String, null: false
    field :biography, String, null: true
    field :avatar, String, null: true
    field :avatar_url, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    def avatar_url
      Rails.application.routes.url_helpers.rails_blob_url(user.avatar)
    end
  end
end
