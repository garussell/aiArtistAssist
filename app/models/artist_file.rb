class ArtistFile < ApplicationRecord
  belongs_to :artist
  has_many :stored_images

  validates_presence_of :image_url, :resources, :goals, :action_steps
end
