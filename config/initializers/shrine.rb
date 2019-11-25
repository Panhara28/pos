require 'shrine/storage/s3'

s3_options = {
  access_key_id: "2J4SKHSCRQZJ5RQQKNL5",
  secret_access_key: "D9x/AFEfIptuY8THn5sYSQKF36TBeuWkVP7W24K98K8",
  bucket: "image-pos",
  endpoint: 'https://sgp1.digitaloceanspaces.com',
  region: 'isgp1'
}

Shrine.storages = {
  cache: Shrine::Storage::S3.new(prefix: 'cache', upload_options: {acl: 'public-read'}, **s3_options),
  store: Shrine::Storage::S3.new(prefix: 'products', upload_options: {acl: 'public-read'}, **s3_options),
}

Shrine.plugin :activerecord