module OpenAiParameters
  def self.image_prompt(content, style)
    cache_key = "image_prompt_#{content}_#{style}"
    fetch_or_cache(cache_key) do 
      {
        "prompt": "Produce a visually stunning artwork with a poetic reference to '#{style}'. Infuse the creation with the essence of the artist's goals: '#{content}'. Explore unique and imaginative elements to make the artwork truly exceptional.",
        "n": 1, # number of images to generate
        "size": "800x800", # size of image to generate
      }
    end
  end

  def self.artist_prompt(content, style)
    cache_key = "artist_prompt_#{content}_#{style}"
    fetch_or_cache(cache_key) do
      {
        "model": "gpt-4",
        "messages": [
          {
            "role": "user",
            "content": "#{content}"
          },
          {
            "role": "user",
            "content": "I'm an artist specializing in #{style} and I'm seeking guidance to enhance my skills. Can you suggest three specific action steps I should take to improve my craft?"
          },
          {
            "role": "assistant",
            "content": "Provide creative and imaginative advice to help the artist progress in their artistic journey."
          }
        ],
          "temperature": 1,
          "top_p": 1,
          "n": 1,
          "stream": false,
          "max_tokens": 350,
          "presence_penalty": 0,
          "frequency_penalty": 0
      }
    end
  end

  def self.resources_prompt(content_response)
    cache_key = "resources_prompt_#{content_response}"
    fetch_or_cache(cache_key) do
      {
        "model": "gpt-4",
        "messages": [
          {
            "role": "user",
            "content": "#{content_response}"
          },
          {
            "role": "assistant",
            "content": "Provide 3 resources with links to articles, videos, or other materials that will help the artist reach their goal."
          }
        ]
      }
    end
  end
  
  def self.fetch_or_cache(key, &block)
    cached = Rails.cache.read(key)

    if cached.present?
      cached
    else
      data = yield
      Rails.cache.write(key, data, expires_in: 1.day)
      data
    end
  end
end