class AiService
  include OpenAiParameters

  def self.get_image(content, style)
    image_prompt = OpenAiParameters.image_prompt(content, style)
    image_response = get_response("/v1/images/generations", image_prompt)

    # Extract the image URL from the response
    image_url = image_response.dig(:data, 0, :url)

    { image_url: image_url }
  end

  def self.get_resources(content)
    resources_prompt = OpenAiParameters.resources_prompt(content)
    resources_response = get_response("/v1/chat/completions", resources_prompt)

    resources = resources_response.dig(:choices, 0, :message, :content)

    { resources: resources }
  end

  def self.artist_prompt(content, style)
    prompt = OpenAiParameters.artist_prompt(content, style)
    initial_response = get_response("/v1/chat/completions", prompt)

    content_response = initial_response.dig(:choices, 0, :message, :content)
    resources_response = get_resources(content_response)

    # Combined responses
    {
      content: content_response,
      resources: resources_response[:resources]
    }
  end

  def self.get_response(url, prompt)
    response = conn.post(url, prompt.to_json)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: "https://api.openai.com") do |f|
      f.headers['Authorization'] = "Bearer #{Rails.application.credentials.open_ai[:api_key]}"
      f.headers['Content-Type'] = 'application/json'
    end
  end
end