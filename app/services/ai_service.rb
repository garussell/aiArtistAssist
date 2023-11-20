class AiService
  def self.artist_prompt(content)
    prompt = {
        "model": "gpt-3.5-turbo",
        "messages": [
            {
                "role": "user",
                "content": "#{content}"
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