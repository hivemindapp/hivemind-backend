module Mutations
  module Blobs
    class CreateDirectUpload < ::Mutations::BaseMutation

      argument :attributes, Types::DirectUploadAttributes, required: true

      field :direct_upload, Types::DirectUploadType, null: false

      def resolve(attributes:)
        blob = ActiveStorage::Blob.create_before_direct_upload!(attributes.to_h)
        
        {
          direct_upload: {
            url: ActiveStorage::Current.set(host: "http://localhost:3000") do
              blob.service_url_for_direct_upload
            end,
            headers: blob.service_headers_for_direct_upload.to_json,
            blob_id: blob.id,
            signed_blob_id: blob.signed_id
          }
        }
      end
    end
  end
end
