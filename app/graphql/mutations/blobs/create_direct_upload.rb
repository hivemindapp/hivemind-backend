require "google/cloud/storage"

module Mutations
  module Blobs
    class CreateDirectUpload < ::Mutations::BaseMutation
      argument :attributes, Types::DirectUploadAttributes, required: true

      field :direct_upload, Types::DirectUploadType, null: false

      def resolve(attributes:)
        blob = ActiveStorage::Blob.create_after_upload!(io: StringIO.new((Base64.decode64(attributes[:checksum].split(",")[1]))), filename: attributes[:filename], content_type: attributes[:content_type])
        
        {
          direct_upload: {
            url: ActiveStorage::Current.set(host: 'http://hivemind-staging-branch.herokuapp.com') do
              blob.service_url_for_direct_upload
            end,
            headers: blob.service_headers_for_direct_upload.merge('Content-Type': blob[:content_type]).to_json,
            signed_blob_id: blob.signed_id
          }
        }
      end
    end
  end
end
