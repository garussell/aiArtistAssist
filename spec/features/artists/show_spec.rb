require 'rails_helper'

RSpec.describe "Artist Show Page" do
  before do
    @artist1 = Artist.create!(
      name: Faker::Artist.name,
      email: Faker::Internet.email,
      style: Faker::Music.genre,
      bio: Faker::TvShows::MichaelScott.quote,
      password: "password"
    )

    visit artist_path(@artist1)
  end

  describe "As a visitor" do
    describe "When I visit an artist's show page" do
      it "I see the artist's name, style, and bio" do
        within(".artist-info") do
          expect(page).to have_content(@artist1.name)
          expect(page).to have_content(@artist1.style)
          expect(page).to have_content(@artist1.bio)
        end
      end

      it "I see a link to edit the artist's info" do
        within(".artist-info") do
          expect(page).to have_link("Edit Info")

          click_on "Edit Info"
        end

        expect(current_path).to eq(edit_artist_path(@artist1))
    
        expect(page).to have_field(:name)
        expect(page).to have_field(:email)
        expect(page).to have_field(:style)
        expect(page).to have_field(:bio)
        expect(page).to have_field(:password)

        expect(page).to have_button("Update Profile")
        expect(page).to have_link("Cancel")
     
      end

      it "I see a link to delete the artist" do
        expect(page).to have_button("Delete Profile")
        
        click_on "Delete Profile"

        expect(page).to have_content("Your profile has been deleted")
        expect(current_path).to eq(root_path)
      end

      it "I see a link to logout" do
        visit root_path
        fill_in "email", with: @artist1.email
        fill_in "password", with: @artist1.password
        click_button "Login"

        expect(current_path).to eq(artist_path(@artist1))

        expect(page).to have_link("Logout")
        click_on "Logout"

        expect(page).to have_content("You have successfully logged out")
        expect(current_path).to eq(root_path)
      end
    end
  end
end