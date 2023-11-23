class AiFacade
  def initialize(goals)
    @goals = goals
  end

  def prompt_response
    style = Artist.pluck(:style).sample

    prompt = AiService.artist_prompt(@goals, style)
    image = AiService.get_image(@goals, style)

    ArtistPath.new(prompt, image, @goals)
  end
end