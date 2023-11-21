require 'rails_helper'

RSpec.describe 'Artist LogIn Page' do
  before do
    @artist1 = Artist.create!(
      name: Faker::Artist.name,
      email: Faker::Internet.email,
      style: Faker::Music.genre,
      bio: Faker::TvShows::MichaelScott.quote,
      password: "password"
    )

    @artist2 = Artist.create!(
      name: Faker::Artist.name,
      email: Faker::Internet.email,
      style: Faker::Music.genre,
      bio: Faker::TvShows::MichaelScott.quote,
      password: "password2"
    )

    visit root_path
  end

  describe 'As a visitor' do
    describe 'When I visit the root path page' do
      it "I see a link to login '/artists/login'" do
        expect(page).to have_link("Login")
      end
      it "I see a place to enter my email and password" do
  
        expect(page).to have_field("email")
        expect(page).to have_field("password")
        expect(page).to have_button("Login")
      end

      it "If I enter a valid email and password, I am directed to my Dashboard page '/artist/:id'" do
        fill_in "email", with: @artist1.email
        fill_in "password", with: @artist1.password
        click_button "Login"

        expect(current_path).to eq artist_path(@artist1.id)
      end

      it "SAD PATH: If I enter an invalid email and password, I am redirected to the root path page and see a flash message" do
        
        fill_in "email", with: @artist1.email
        fill_in "password", with: "wrongpassword"
        click_button "Login"

        expect(current_path).to eq root_path
        expect(page).to have_content("Artist not found")
      end
    end
  end
end