require 'rails_helper'

RSpec.describe "Update Artist File", type: :feature do
  before do
    @artist = Artist.create!(
      name: Faker::Artist.name,
      email: Faker::Internet.email,
      style: Faker::Music.genre,
      bio: Faker::TvShows::MichaelScott.quote,
      password: "password"
    )

    @artist_file = @artist.artist_files.create!(
      image_url: Faker::LoremFlickr.image,
      resources: [Faker::Quote.jack_handey, Faker::Quote.jack_handey, Faker::Quote.jack_handey],
      goals: Faker::TvShows::Friends.quote,
      action_steps: Faker::Quote.famous_last_words
    )

    visit root_path
    fill_in "email", with: @artist.email
    fill_in "password", with: @artist.password
    click_button "Login"
  end

  describe "As a visitor" do
    describe "When I visit an artist's show page" do
      it "can update the goals section", :vcr do
        expect(@artist.artist_files.count).to eq(1)
        expect(@artist.artist_files.first.image_url).to eq(@artist_file.image_url)
        
        expect(page).to have_content("New AI Photo")
        click_on "New AI Photo"

        expect(@artist_file.image_url).to_not eq(@artist.artist_files.first.image_url)
      end

      it "can update the image and flash success" do
        expect(@artist.artist_files.count).to eq(1)
        expect(@artist.artist_files.first.image_url).to eq(@artist_file.image_url)

        saved_image_file1 = Rails.root.join('spec', 'fixtures', 'files', 'image1.jpg')
        @artist_file.saved_image.attach(io: File.open(saved_image_file1), filename: 'image1.jpg')

        # ActiveStorage::Attachment
        expect(@artist_file.saved_image.attached?).to eq(true)
        expect(@artist_file.saved_image).to be_an_instance_of(ActiveStorage::Attached::One)
        expect(@artist_file.saved_image).to_not eq(@artist.artist_files.first.saved_image)
      end

      it "has upload image button" do 
        fill_in with: "I want to be a better artist"
        
        # Attach an image to simulate the upload
        saved_image_file1 = Rails.root.join('spec', 'fixtures', 'files', 'image1.jpg')
        attach_file("artist_file[saved_image]", saved_image_file1)
      
        expect(page).to have_content("Upload Image")
        click_on "Upload Image"

        expect(page).to have_content("File updated successfully.")
      end
    end
  end
end