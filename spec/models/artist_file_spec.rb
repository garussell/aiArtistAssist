require 'rails_helper'

RSpec.describe ArtistFile, type: :model do
  before do
    @artist1 = Artist.create!(
      name: Faker::Artist.name,
      email: Faker::Internet.email,
      style: Faker::Music.genre,
      bio: Faker::TvShows::MichaelScott.quote,
      password: "password"
    )
    @artist1.artist_files.create!(
      image_url: Faker::LoremFlickr.image,
      resources: [Faker::Quote.jack_handey, Faker::Quote.jack_handey, Faker::Quote.jack_handey],
      goals: Faker::TvShows::Friends.quote,
      action_steps: Faker::Quote.famous_last_words
    )
  end

  describe 'validations' do
    it { should validate_presence_of(:image_url) }
    it { should validate_presence_of(:resources) }
    it { should validate_presence_of(:goals) }
    it { should validate_presence_of(:action_steps) }
  end

  describe 'relationships' do
    it { should belong_to(:artist) }
  end

  describe 'instance methods' do
    it '#update_style' do
      expect(@artist1.style).to_not eq("Impressionism")

      @artist1.artist_files.first.update_style("Impressionism")

      expect(@artist1.style).to eq("Impressionism")
      expect(@artist1.artist_files.first.style).to eq("Impressionism")
    end
  end
end