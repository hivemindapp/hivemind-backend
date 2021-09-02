module Mutations
  module Posts
    class CreatePost < ::Mutations::BaseMutation
      argument :title, String, required: true
      argument :description, String, required: true
      argument :user_id, Integer, required: true
      argument :image_ids, [String], required: false

      type Types::PostType

      def resolve(user_id:, title:, description:, image_ids:)
        post = User.find(user_id).posts.create!(title: title, description: description)
        image_ids.each do |image|
          post.images.attach(image)
        end
        
        post
      end
    end
  end
end
