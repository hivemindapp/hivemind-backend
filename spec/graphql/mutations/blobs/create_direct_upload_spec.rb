require 'rails_helper'

RSpec.describe Mutations::Blobs::CreateDirectUpload, type: :request do
  set_graphql_type

  describe 'create_direct_upload' do
    types = GraphQL::Define::TypeDefiner.instance

    it 'creates a new blob' do
      expect do
        post '/graphql', params: { query: query }
      end.to change{ ActiveStorage::Blob.all.count }.by(1)
    end

    it 'returns a direct upload type object' do
      post '/graphql', params: { query: query }

      json = JSON.parse(response.body, symbolize_names: true)
      data = json[:data][:createDirectUpload]

      blob = ActiveStorage::Blob.all.last
      
      expect(data).to be_a Hash

      expect(data[:directUpload][:signedBlobId]).to eq blob.signed_id
    end

    def query
      <<~GQL
        mutation createDirectUpload {
          createDirectUpload(input: 
            {attributes: {
                filename: "dev.to"
                contentType: "image/jpeg"
                checksum: #{File.read('spec/fixtures/image.txt')}
                byteSize: 2019
              }
            }
          ){ 
            directUpload {
              signedBlobId
            }
          }
        }
      GQL
    end
  end
end
