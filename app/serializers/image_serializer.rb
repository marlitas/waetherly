class ImageSerializer
  include JSONAPI::Serializer
  attributes :location, :credit, :image_url
end
