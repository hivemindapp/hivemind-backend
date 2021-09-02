class Types::DirectUploadType < Types::BaseObject
  field :url, String, 'Upload URL', null: false
  field :headers, String, 'HTTP request headers', null: false
  field :blob_id, ID, 'Blob record id', null: false
  field :signed_blob_id, ID, 'Blob signed record id', null: false
end
