class CreateDirectUploadInputType < Types::BaseInputObject
  argument :filename, String, "Original file name", required: true
  argument :byte_size, Int, "File size (bytes)", required: true
  argument :checksum, String, "MD5 file checksum as base64", required: true
  argument :content_type, String, "File content type", required: true
end
