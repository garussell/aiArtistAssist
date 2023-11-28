class ArtistFile < ApplicationRecord
  belongs_to :artist

  validates_presence_of :image_url, :resources, :goals, :action_steps
  has_one_attached :saved_image


  # def saved_image_url
  #   if saved_image.attached?
  #     Rails.application.routes.url_helpers.rails_blob_url(saved_image, only_path: true)
  #   else
  #     image_url
  #   end 
  # end
end
