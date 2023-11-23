class ArtistPath
  attr_reader :id, :goals, :action_steps, :resources, :image_url

  def initialize(prompt, image, goals)
    @id = nil
    @goals = goals
    @action_steps = prompt[:content]
    @resources = format_resources(prompt[:resources])
    @image_url = image[:image_url]
  end

  def format_resources(resources)
    resources_array = resources.split("\n\n").map { |item| item.sub(/^\d+\.\s+/, '') }
    # extract_weblink = resources_array.map { |resource| resource.match(/\(([^)]+)\)/)&.captures&.first }
  end
end