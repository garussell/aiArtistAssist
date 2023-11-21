class Artist < ApplicationRecord
  has_many :artist_files

  validates_presence_of :name, :email, :style, :bio, :password
  
  has_secure_password
end
