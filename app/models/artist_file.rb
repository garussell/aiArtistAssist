class ArtistFile < ApplicationRecord
  validates_presence_of :topic, :image_url, :resources, :goals, :action_steps
end
