require 'shrine/storage/s3'

s3_options = {
  access_key_id: ENV['ACCESS_KEY'],
  secret_access_key: ENV['SECRET'],
  bucket: ENV['BUCKET'],
  endpoint: ENV['ENDPOINT'],
  region: ENV['REGION']
}

Shrine.storages = {
  cache: Shrine::Storage::S3.new(prefix: 'cache', upload_options: {acl: 'public-read'}, **s3_options),
  store: Shrine::Storage::S3.new(prefix: ENV['SERVER_IMAGE'], upload_options: {acl: 'public-read'}, **s3_options),
}

Shrine.plugin :activerecord