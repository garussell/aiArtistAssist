class StoredImage < ApplicationRecord
  has_one_attached :image
  belongs_to :artist_file

  validates_presence_of :image
end
