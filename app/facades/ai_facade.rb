class AiFacade
  def initialize(goals)
    @goals = goals
  end

  def prompt_response
    artist_style = Artist.pluck(:style).sample

    prompt = AiService.artist_prompt(@goals, artist_style)
    image = AiService.get_image(artist_style)

    ArtistPath.new(prompt, image, @goals)
  end
end