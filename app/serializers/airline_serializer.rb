class AirlineSerializer
  include JSONAPI::Serializer
  attributes :name, :image_url, :slug #controlling what is exposed by our serliazer

  has_many :reviews #defining that relationship
end
