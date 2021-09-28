class UsersSerializer
  include JSONAPI::Serializer
  attributes :email

  attributes :api_key do |object|
    object.api_keys.order(:created_at).first[:token]
  end
end
