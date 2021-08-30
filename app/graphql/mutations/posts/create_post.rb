module Mutations
  module Posts
    class CreatePost < ::Mutations::BaseMutation
      argument :title, String, required: true
      argument :description, String, required: true
      argument :image, String, required: false
      argument :user_id, Integer, required: true

      type Types::PostType
      def resolve(user_id:, **attributes)
        User.find(user_id).posts.create!(attributes)
      end
    end
  end
end
