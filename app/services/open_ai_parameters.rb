module OpenAiParameters
  def self.image_prompt(style)
    {
      "prompt": "New artwork with poetic reference to #{style}",
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
          "content": "I'm an artist specializing in #{style} and want to get better at my craft. I'm looking for resources to help me with my goals."
        },
        {
          "role": "assistant",
          "content": "Help the artist with their problem by providing 3 concise suggestions for next 3 action steps towards reaching their goal."
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
          "content": "Provide 3 resources with links to articles, videos, or other resources that will help the artist reach their goal."
        }
      ]
    }
  end
end