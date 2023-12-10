require 'rails_helper'

RSpec.describe "Destroy Artist Profile", type: :feature do
  before do
    @artist1 = Artist.create!(
      name: Faker::Artist.name,
      email: Faker::Internet.email,
      style: Faker::Music.genre,
      bio: Faker::TvShows::MichaelScott.quote,
      password: "password"
    )
  end

  describe "As a visitor" do
    describe "When I visit an artist's show page" do
      it "I see a button to delete my profile, and when I click that button, I see a flash message and am redirected to the home page" do
        visit root_path
        fill_in "email", with: @artist1.email
        fill_in "password", with: @artist1.password
        click_button "Login"

        visit root_path

        expect(page).to have_button("Delete Profile")
        click_on "Delete Profile"

        expect(page).to have_content("Your profile has been deleted")
        expect(current_path).to eq(root_path)
      end
    end
  end
end