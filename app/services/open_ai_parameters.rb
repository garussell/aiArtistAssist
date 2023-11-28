module OpenAiParameters
  def self.image_prompt(content, style)
    {
      "prompt": "Produce a visually stunning artwork with a poetic reference to '#{style}'. Infuse the creation with the essence of the artist's goals: '#{content}'. Explore unique and imaginative elements to make the artwork truly exceptional.",
      "n": 1, # number of images to generate
      "size": "800x800", # size of image to generate
    }
  end

  def self.artist_prompt(content, style)
    {
      "model": "gpt-4",
      "messages": [
        {
          "role": "user",
          "content": "As an artist specializing in #{style}, I'm eager to elevate my skills and creativity. With a focus on my current goals—#{content}, I'm reaching out for guidance. Could you recommend three specific action steps I should take to further enhance my craft?"
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
          "content": "Provide 3 resources with links (in markdown format) to articles, videos, or other materials that will help the artist reach their goal."
        }
      ]
    }
  end
end