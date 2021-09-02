require 'rails_helper'

RSpec.describe Mutations::Comments::CreateComment, type: :request do
  set_graphql_type

  describe 'create comment' do
    it 'creates a new comment' do
      user1 = create(:user, :with_avatar)
      user2 = create(:user, :with_avatar)

      posts1 = create_list(:post, 5, :with_images, user: user1)

      expect(Comment.all.count).to eq(0)

      post '/graphql', params: { query: query(user_id: user1.id, post_id: posts1[0].id) }

      json = JSON.parse(response.body, symbolize_names: true)
      data = json[:data][:createComment]

      new_comment = posts1[0].comments.last

      expect(Comment.all.count).to eq(1)
      expect(data[:content]).to eq(new_comment.content)
      expect(data[:upvotes]).to eq(new_comment.upvotes)
      expect(data[:downvotes]).to eq(new_comment.downvotes)
      expect(data[:user][:id]).to eq(user1.id.to_s)
      expect(data[:user][:username]).to eq(user1.username)
      expect(data[:user][:avatar]).to eq(rails_blob_url(user1.avatar, only_path: true))
      expect(new_comment.post_id).to eq(posts1[0].id)
    end

    def query(user_id:, post_id:)
      <<~GQL
        mutation createComment {
          createComment(input: {
            content: "Bzzzz I'm a bee!"
            userId: #{user_id}
            postId: #{post_id}
            }
          ){
            content
            upvotes
            downvotes
            user {
              id
              username
              avatar
            }
          }
        }
      GQL
    end
  end
end
