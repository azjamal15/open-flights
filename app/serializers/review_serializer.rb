class ReviewSerializer
  include JSONAPI::Serializer
  attributes :title, :description, :score, :airline_id  #controlling what is exposed by our serliazer
end
