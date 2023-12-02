class AiFacade
  def initialize(goals, style)
    @goals = goals
    @style = style
  end

  def prompt_response
    prompt = AiService.artist_prompt(@goals, @style)
    image = AiService.get_image(@goals, @style)
    ArtistPath.new(prompt, image, @goals)
  end

  def get_image
    AiService.get_image(@goals, @style)
  end
end