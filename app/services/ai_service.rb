class AiService
  def self.get_image(prompt)
    image = {
      "prompt": "#{prompt}",
      "n": 1, # number of images to generate
      "size": "1024x1024", # size of image to generate
    }

    get_response(image)
  end

  def self.artist_prompt(content)
    prompt = {
        "model": "gpt-3.5-turbo",
        "messages": [
            {
                "role": "user",
                "content": "#{content}"
            },
            {
                "role": "user",
                "content": "I'm an artist and want to get better at my craft. I'm not sure what to do next."
            }
            {
                "role": "assistant",
                "content": "Help the artist with their problem by providing suggestions for the next 3 action steps towards reaching their goals."
            },
        ],
        "temperature": 1,
        "top_p": 1,
        "n": 1,
        "stream": false,
        "max_tokens": 250,
        "presence_penalty": 0,
        "frequency_penalty": 0
      }

      get_response(prompt)
  end

  def self.get_response(prompt)
    response = conn.post do |req|
      req.url "/v1/engines/gpt-3.5-turbo/completions"
      req.headers['Content-Type'] = 'application/json'
      req.headers['Authorization'] = "Bearer #{Rails.application.credentials.open_ai[:api_key]}"
      req.body = prompt.to_json
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: "https://api.openai.com") do |f|
      f.adapter Faraday.default_adapter
    end
  end
end