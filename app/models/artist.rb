class Artist < ApplicationRecord
  has_many :artist_files, dependent: :destroy

  validates_presence_of :name, :email, :style, :bio
  validates_uniqueness_of :email

  validates_presence_of :password
  validates_confirmation_of :password, on: [:create, :update]
  
  has_secure_password
end
