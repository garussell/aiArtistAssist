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
    
        expect(page).to have_field('artist[name]')
        expect(page).to have_field('artist[email]')
        expect(page).to have_field('artist[style]')
        expect(page).to have_field('artist[bio]')
        expect(page).to have_field('artist[password]')

        expect(page).to have_button("Update Profile")
        expect(page).to have_link("Cancel")
     
      end

      it "I see a link to delete the artist" do
        expect(page).to have_button("Delete Profile")
        
        click_on "Delete Profile"

        expect(page).to have_content("Your profile has been deleted")
        expect(current_path).to eq(root_path)
      end

      it "I see a link to logout and artist login does not render" do
        expect(current_path).to eq(artist_path(@artist1))

        expect(page).to have_link("Logout")
        expect(page).to_not have_link("Login")

        expect(page).to_not have_content("Email")
        expect(page).to_not have_content("Password")
        
        click_on "Logout"

        expect(page).to have_content("You have successfully logged out")
        expect(current_path).to eq(root_path)
      end

      it "flashes a message 'artist not found' if artist does not exist" do
        visit artist_path(10000)

        expect(page).to have_content("Artist not found")
        expect(current_path).to eq(root_path)
      end
    end

    describe "#ai-prompt-section" do
      it "I see a section for ai prompts" do
        click_on "Delete Prompt"

        expect(page).to have_content("AI Prompt")
        expect(page).to have_content("What can you tell me about your next creative project?")
        expect(page).to have_field("artist_file[goals]")

        expect(page).to have_button("Get Prompt")
        
        expect(page).to_not have_content("Collection of Ideas")
      end

      it "has a section that displays content when there is at least one artist file" do
        artist_file1 = @artist1.artist_files.create!(
          image_url: Faker::LoremFlickr.image,
          resources: [Faker::Quote.jack_handey, Faker::Quote.jack_handey, Faker::Quote.jack_handey],
          goals: Faker::TvShows::Friends.quote,
          action_steps: Faker::Quote.famous_last_words
        )

        resources = JSON.parse(artist_file1.resources)
        visit artist_path(@artist1)

        expect(page).to have_content("Collection of Ideas")
        expect(page).to have_content(artist_file1.goals)
        expect(page).to have_content(artist_file1.action_steps)
        expect(page).to have_content("Resources:")
      end
    end
  end
end