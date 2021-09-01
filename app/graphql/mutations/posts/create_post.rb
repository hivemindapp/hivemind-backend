module Mutations
  module Posts
    class CreatePost < ::Mutations::BaseMutation
      argument :title, String, required: true
      argument :description, String, required: true
      argument :user_id, Integer, required: true
      argument :images, Array, required: false

      type Types::PostType
      def resolve(user_id:, :title, :description)
        post = User.find(user_id).posts.create!(title: title, description: description)
        images.each do |image|
          post.images.attach(image)
        end
      end
    end
  end
end
