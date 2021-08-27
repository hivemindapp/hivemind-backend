module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :username, String, null: true
    field :region, String, null: true
    field :biography, String, null: true
    field :image, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
