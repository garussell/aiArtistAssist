class ResponseSerializer
  include JSONAPI::Serializer

  attributes :id, :action_steps, :resources, :goals, :image_url
end