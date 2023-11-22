class Artist < ApplicationRecord
  has_many :artist_files, dependent: :destroy

  validates_presence_of :name, :email, :style, :bio
  validates_presence_of :password, on: :create
  
  has_secure_password
end
