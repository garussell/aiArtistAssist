module OpenAiParameters
  def self.image_prompt(content, style)
    artist_list = artist_sample_list.sample(3).join(", ")
    {
      "prompt": "Create a visually stunning artwork with a poetic reference to the following statement: '#{style}'. Infuse the creation with the essence of the artist's description of the project: '#{content}'. Incorporate vibrant colors, surreal elements, and a sense of tranquility to evoke a mood of peaceful exploration. Feel free to draw inspiration from artists like #{artist_list}.",
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
          "content": "As an artist looking for ideas related to #{style}, I'm eager to elevate my skills and creativity. My focus is this: #{content}, I'm reaching out for guidance. Could you recommend three specific action steps I should take next?"
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

  def self.artist_sample_list
    ["Leonardo da Vinci", "Vincent van Gogh", "Pablo Picasso", "Claude Monet", "Salvador Dalí", "Georgia O'Keeffe", "Frida Kahlo", "Michelangelo", "Jackson Pollock", "Andy Warhol", "Rembrandt", "Edvard Munch", "Henri Matisse", "Gustav Klimt", "Mark Rothko", "Yayoi Kusama", "Banksy", "Kazimir Malevich", "Fernando Botero", "Joan Miró", "Diego Rivera", "Hokusai", "Roy Lichtenstein", "Ai Weiwei", "Marcel Duchamp", "Jean-Michel Basquiat", "Piet Mondrian", "Caravaggio"]
  end
end