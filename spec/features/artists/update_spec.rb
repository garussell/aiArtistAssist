require 'rails_helper'

RSpec.describe 'Artist Update Page' do
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
    
    visit root_path
    fill_in "email", with: @artist1.email
    fill_in "password", with: @artist1.password
    click_button "Login"

    click_on "Edit Info"
  end

  describe "As a visitor" do
    describe "When I visit an artist's edit page", js: true do
      it "I see a form to edit the artist's info" do
        expect(page).to have_content("Update Info")
        expect(page).to have_field('artist[name]')
        expect(page).to have_field('artist[email]')
        expect(page).to have_field('artist[style]')
        expect(page).to have_field('artist[bio]')
        expect(page).to have_button("Update Profile")

        expect(page).to have_link("Cancel")
      end

      it "I see a toggle for update password" do
        expect(page).not_to have_field("artist_current_password")
        expect(page).not_to have_field("artist_password")
        expect(page).not_to have_field("artist_password_confirmation")
        expect(page).to have_content("Update Password")
       
      end

      it "When I fill in the form with valid information and click submit, I am redirected to my dashboard" do
        expect(@artist1.bio).to_not eq("I like to paint happy little trees")

        fill_in "artist[name]", with: @artist1.name
        fill_in "artist[email]", with: @artist1.email
        fill_in "artist[style]", with: @artist1.style
        fill_in "artist[bio]", with: "I like to paint happy little trees"
        
        click_on "Update Profile"

        expect(current_path).to eq(artist_path(@artist1.id))
        expect(page).to have_content("Your profile has been updated")
        expect(@artist1.reload.bio).to eq("I like to paint happy little trees")
      end

      it "SAD PATH: When I fill in the form with invalid email, I am redirected to the edit artist page and see a flash message" do
        fill_in "artist[name]", with: @artist1.name
        fill_in "artist[email]", with: ""
        fill_in "artist[style]", with: @artist1.style
        fill_in "artist[bio]", with: @artist1.bio

        check "Update Password" # wait for javascript to load via selenium

        fill_in "artist[password]", with: @artist1.password
        fill_in "artist[password_confirmation]", with: @artist1.password

        click_on "Update Profile"

        expect(current_path).to eq(edit_artist_path(@artist1))
        expect(page).to have_content("Email can't be blank")
      end

      it "SAD PATH: When I fill in the form with invalid style, I am redirected to the edit artist page and see a flash message" do
        fill_in "artist[name]", with: @artist1.name
        fill_in "artist[email]", with: @artist1.email
        fill_in "artist[style]", with: ""
        fill_in "artist[bio]", with: @artist1.bio

        check "Update Password" # wait for javascript to load via selenium

        fill_in "artist[password]", with: @artist1.password
        fill_in "artist[password_confirmation]", with: @artist1.password

        click_on "Update Profile"

        expect(current_path).to eq(edit_artist_path(@artist1))
        expect(page).to have_content("Style can't be blank")
      end

      it "SAD PATH: When I fill in the form with invalid bio, I am redirected to the edit artist page and see a flash message" do
        fill_in "artist[name]", with: @artist1.name
        fill_in "artist[email]", with: @artist1.email
        fill_in "artist[style]", with: @artist1.style
        fill_in "artist[bio]", with: ""

        check "Update Password" # wait for javascript to load via selenium

        fill_in "artist[password]", with: @artist1.password
        fill_in "artist[password_confirmation]", with: @artist1.password

        click_on "Update Profile"

        expect(current_path).to eq(edit_artist_path(@artist1))
        expect(page).to have_content("Bio can't be blank")
      end

      it "SAD PATH: When I fill in the form with invalid password, I am redirected to the edit artist page and see a flash message" do
        fill_in "artist[name]", with: @artist1.name
        fill_in "artist[email]", with: @artist1.email
        fill_in "artist[style]", with: @artist1.style
        fill_in "artist[bio]", with: @artist1.bio

        check "Update Password" # wait for javascript to load via selenium

        fill_in "artist[password]", with: ""
        fill_in "artist[password_confirmation]", with: @artist1.password

        click_on "Update Profile"

        expect(current_path).to eq(edit_artist_path(@artist1))
        expect(page).to have_content("Passwords do not match")
      end

      it "SAD PATH: When I fill in the form with invalid password confirmation, I am redirected to the edit artist page and see a flash message" do
        fill_in "artist[name]", with: @artist1.name
        fill_in "artist[email]", with: @artist1.email
        fill_in "artist[style]", with: @artist1.style
        fill_in "artist[bio]", with: @artist1.bio

        check "Update Password" # wait for javascript to load via selenium

        fill_in "artist[password]", with: @artist1.password
        fill_in "artist[password_confirmation]", with: "wrongpassword"

        click_on "Update Profile"

        expect(current_path).to eq(edit_artist_path(@artist1))
     
        expect(page).to have_content("Passwords do not match")
      end
    end


    describe "user must be logged in to edit their profile" do
      it "If I am not logged in, I am redirected to the root path and see a flash message" do
        click_on "Logout"

        visit edit_artist_path(@artist1)
        expect(page).to have_content("You must be logged in to edit your profile")
      end
    end
  end
end