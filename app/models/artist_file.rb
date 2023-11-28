class ArtistFile < ApplicationRecord
  belongs_to :artist

  validates_presence_of :image_url, :resources, :goals, :action_steps
end
