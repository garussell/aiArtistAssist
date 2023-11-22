require 'rails_helper'

RSpec.describe "Create Artist Provile", type: :feature do
  before do

    visit root_path
    click_on "Click Here to create an account"
  end

  describe "As a visitor" do  
    describe "When I visit the new artist page" do
      it "I see a form to create a new artist profile" do
        expect(page).to have_content("Create A Profile")
        expect(page).to have_field("artist[name]")
        expect(page).to have_field("artist[email]")
        expect(page).to have_field("artist[style]")
        expect(page).to have_field("artist[bio]")
        expect(page).to have_field("artist[password]")
        expect(page).to have_button("Create Profile")

        expect(page).to have_link("Cancel")
      end

      it "When I fill in the form with valid information and click submit, I am redirected to my dashboard" do
        fill_in "artist[name]", with: "Bob Ross"
        fill_in "artist[email]", with: "bob@fake.com"
        fill_in "artist[style]", with: "Painting"
        fill_in "artist[bio]", with: "I like to paint happy little trees"
        fill_in "artist[password]", with: "password"
        fill_in "artist[password_confirmation]", with: "password"

        click_on "Create Profile"

        expect(current_path).to eq(artist_path(Artist.last.id))
        expect(page).to have_content("Your profile has been created")
        expect(page).to have_content("Bob Ross")
        expect(page).to have_content("Painting")
        expect(page).to have_content("I like to paint happy little trees")
      end

      it "SAD PATH: When I fill in the form with invalid email, I am redirected to the new artist page and see a flash message" do
        fill_in "artist[name]", with: "Bob Ross"
        # fill_in "artist[email]", with: "bob@fake.com"
        fill_in "artist[style]", with: "Painting"
        fill_in "artist[bio]", with: "I like to paint happy little trees"
        fill_in "artist[password]", with: "password"
        fill_in "artist[password_confirmation]", with: "password"

        click_on "Create Profile"

        expect(current_path).to eq(new_artist_path)
        expect(page).to have_content("Email can't be blank")
      end

      it "SAD PATH: When I fill in the form with invalid style, I am redirected to the new artist page and see a flash message" do
        fill_in "artist[name]", with: "Bob Ross"
        fill_in "artist[email]", with: "bob@fake.com"
        # fill_in "artist[style]", with: "Painting"
        fill_in "artist[bio]", with: "I like to paint happy little trees"
        fill_in "artist[password]", with: "password"
        fill_in "artist[password_confirmation]", with: "password"

        click_on "Create Profile"

        expect(current_path).to eq(new_artist_path)
        expect(page).to have_content("Style can't be blank")
      end

      it "SAD PATH: When I fill in the form with invalid bio, I am redirected to the new artist page and see a flash message" do
        fill_in "artist[name]", with: "Bob Ross"
        fill_in "artist[email]", with: "bob@fake.com"
        fill_in "artist[style]", with: "Painting"
        # fill_in "artist[bio]", with: "I like to paint happy little trees"
        fill_in "artist[password]", with: "password"
        fill_in "artist[password_confirmation]", with: "password"

        click_on "Create Profile"

        expect(current_path).to eq(new_artist_path)
        expect(page).to have_content("Bio can't be blank")
      end

      it "SAD PATH: When I fill in the form with invalid password, I am redirected to the new artist page and see a flash message" do
        fill_in "artist[name]", with: "Bob Ross"
        fill_in "artist[email]", with: "bob@fake.com"
        fill_in "artist[style]", with: "Painting"
        fill_in "artist[bio]", with: "I like to paint happy little trees"
        # fill_in "artist[password]", with: "password"
        fill_in "artist[password_confirmation]", with: "password"

        click_on "Create Profile"

        expect(current_path).to eq(new_artist_path)
        expect(page).to have_content("Passwords do not match")
      end

      it "SAD PATH: When I fill in the form with invalid password confirmation, I am redirected to the new artist page and see a flash message" do
        fill_in "artist[name]", with: "Bob Ross"
        fill_in "artist[email]", with: "bob@fake.com"
        fill_in "artist[style]", with: "Painting"
        fill_in "artist[bio]", with: "I like to paint happy little trees"
        fill_in "artist[password]", with: "password"
        fill_in "artist[password_confirmation]", with: "wrongpassword"

        click_on "Create Profile"

        # expect(current_path).to eq(new_artist_path)
        expect(page).to have_content("Passwords do not match")
      end
    end
  end
end