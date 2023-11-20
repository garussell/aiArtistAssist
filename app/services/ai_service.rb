class AiService
  def self.get_image(style)
    image_prompt = {
      "prompt": "Edgy gothic art with elements of #{style}",
      "n": 1, # number of images to generate
      "size": "1024x1024", # size of image to generate
    }

    image_response = get_response("/v1/images/generations", image_prompt)

    # Extract the image URL from the response
    image_url = image_response.dig(:data, 0, :url)

    { image_url: image_url }
  end

  def self.artist_prompt(content, style)
    prompt = {
      "model": "gpt-4",
      "messages": [
        {
          "role": "user",
          "content": "#{content}"
        },
        {
          "role": "user",
          "content": "I'm an artist specializing in #{style} and want to get better at my craft. I'm looking for resources to help me with my goals."
        },
        {
          "role": "assistant",
          "content": "Help the artist with their problem by providing 3 concise suggestions for next 3 action steps towards reaching their goal."
        },
        {
          "role": "assistant",
          "content": "Provide 3 resources with links to articles, videos, or other resources that will help the artist reach their goal."
        }
      ],
        "temperature": 1,
        "top_p": 1,
        "n": 1,
        "stream": false,
        "max_tokens": 250,
        "presence_penalty": 0,
        "frequency_penalty": 0
    }

    initial_response = get_response("/v1/chat/completions", prompt)

    # Extract the content from the initial response
    content_response = initial_response.dig(:choices, 0, :message, :content)

    # Generate resources separately
    resources_prompt = {
      "model": "gpt-4",
      "messages": [
        {
          "role": "user",
          "content": "#{content_response}"
        },
        {
          "role": "assistant",
          "content": "Provide 3 resources with links to articles, videos, or other resources that will help the artist reach their goal."
        }
      ]
    }

    resources_response = get_response("/v1/chat/completions", resources_prompt)

    # Combine the responses
    {
      content: content_response,
      resources: resources_response.dig(:choices, 0, :message, :content),
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