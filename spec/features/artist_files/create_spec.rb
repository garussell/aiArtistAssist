require 'rails_helper'

RSpec.describe "Artist Files Create", type: :feature do
  before do
    @artist = Artist.create!(
      name: Faker::Artist.name,
      email: Faker::Internet.email,
      style: Faker::Music.genre,
      bio: Faker::TvShows::MichaelScott.quote,
      password: "password"
    )

    visit root_path
    fill_in "email", with: @artist.email
    fill_in "password", with: @artist.password
    click_button "Login"
  end

  describe "As a visitor" do
    describe "When I visit an artist's show page" do
      it "I see a section to add my goals, and when I fill out that section and click 'Get Prompt', I wait for AI and then see my new idea", :vcr do
        expect(@artist.artist_files.count).to eq(0)

        fill_in "artist_file[goals]", with: "I want to be a famous artist"
        click_on "Get Prompt"

        expect(page).to have_content("I want to be a famous artist")
        expect(@artist.artist_files.count).to eq(1)
      end

      it "SAD PATH: When I fill out the goals section with no content and click 'Get Prompt', I see a flash message", :vcr do
        expect(@artist.artist_files.count).to eq(0)
        fill_in "artist_file[goals]", with: ""
        click_on "Get Prompt"

        expect(page).to have_content("You must share your goal for this to work.")
        expect(@artist.artist_files.count).to eq(0)
      end
    end
  end
end