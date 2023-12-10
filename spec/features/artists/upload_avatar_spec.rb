require 'rails_helper'

RSpec.describe "Upload Avatar" do
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

    visit root_path
  end

  describe "As a visitor" do
    describe "When I visit an artist's show page" do
      it "I see a section to upload an avatar, and when I fill out that section and click 'Upload Avatar', I see my new avatar" do
        expect(@artist.avatar.attached?).to eq(false)

        expect(page).to have_field("artist[avatar]")
        expect(page).to have_button("Upload Avatar")

        attach_file('artist[avatar]', Rails.root.join('app/assets', 'classical_guitar_and_dance.png'))
        click_on "Upload Avatar"

        expect(page).to have_content("Your avatar has been updated")
      end
    end
  end
end