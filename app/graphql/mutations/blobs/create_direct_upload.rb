module Mutations
  module Blobs
    class CreateDirectUpload < ::Mutations::BaseMutation
      argument :input, Types::CreateDirectUploadInputType, required: true

      type Types::DirectUploadType

      def resolve(input:)
        blob = ActiveStorage::Blob.create_before_direct_upload!(input.to_h)
        
        {
          direct_upload: {
            url: blob.service_url_for_direct_upload,
            headers: blob.service_headers_for_direct_upload.to_json,
            blob_id: blob.id,
            signed_blob_id: blob.signed_id
          }
        }
      end
    end
  end
end
