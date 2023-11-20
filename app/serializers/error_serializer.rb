class ErrorSerializer
  include JSONAPI::Serializer
  
  def self.format_errors(error)
    {
      errors: [
        {
          detail: error
        }
      ]
    }
  end
end