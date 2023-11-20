class ArtistPath
  attr_reader :id, :goals, :action_steps, :resources, :image_url

  def initialize(prompt, image, goals)
    @id = nil
    @goals = goals
    @action_steps = prompt[:content]
    @resources = prompt[:resources]
    @image_url = image[:image_url]
  end
end