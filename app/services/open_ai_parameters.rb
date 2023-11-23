module OpenAiParameters
  def self.image_prompt(content, style)
    {
      "prompt": "Produce a visually stunning artwork with a poetic reference to '#{style}'. Infuse the creation with the essence of the artist's goals: '#{content}'. Explore unique and imaginative elements to make the artwork truly exceptional.",
      "n": 1, # number of images to generate
      "size": "1024x1024", # size of image to generate
    }
  end

  def self.artist_prompt(content, style)
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
          "content": "Provide detailed and actionable advice to help the artist progress in their artistic journey."
          # "Provide creative and motivating suggestions to assist the artist in their pursuit of artistic excellence."
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

  def self.resources_prompt(content_response)
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