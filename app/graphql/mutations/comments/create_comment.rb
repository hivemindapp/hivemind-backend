module Mutations
  module Comments
    class CreateComment < ::Mutations::BaseMutation
      argument :content, String, required: true
      argument :user_id, Integer, required: true
      argument :post_id, Integer, required: true

      type Types::CommentType
      def resolve(user_id:, post_id:, content:)
        Post.find(post_id).comments.create!(content: content, user_id: user_id)
      end
    end
  end
end
