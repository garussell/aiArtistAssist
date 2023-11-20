class Artist < ApplicationRecord
  has_many :artist_files

  validates_presence_of :name, :style, :bio
  validates_presence_of :password, on: :create
  has_secure_password
end
