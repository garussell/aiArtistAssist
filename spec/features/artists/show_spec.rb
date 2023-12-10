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
      style: Faker::Music.genre,
      action_steps: Faker::Quote.famous_last_words
    )

    visit root_path
    fill_in "email", with: @artist1.email
    fill_in "password", with: @artist1.password
    click_button "Login"
  end

  describe "As a visitor" do
    describe "#ai-prompt-section" do
      it "I see a section for ai prompts" do
        expect(page).to have_content("AI Prompt")
        expect(page).to have_field("artist_file[goals]")

        expect(page).to have_button("Get Prompt")
        expect(page).to have_content("Collection of Ideas")
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

      it "promt can be deleted" do
        visit artist_artist_file_path(@artist1, @artist1.artist_files.first)

        expect(page).to have_button("Delete")
        click_on "Delete"

        expect(page).to have_content("File deleted successfully")
        expect(current_path).to eq(artist_path(@artist1))
      end
    end

    describe "artist files" do
      it "I see a section for artist files" do
        expect(page).to have_content("Collection of Ideas")
        expect(@artist1.artist_files.count).to eq(1)

        expect(page).to have_content("Created:")
        expect(page).to have_content(@artist1.artist_files.first.goals)
        expect(page).to have_content(@artist1.artist_files.first.action_steps)
        expect(page).to have_content("Resources:")
      end

      it "changes when adding more artist files >2 <4" do
        2.times do @artist1.artist_files.create!(
          image_url: Faker::LoremFlickr.image,
          resources: [Faker::Quote.jack_handey, Faker::Quote.jack_handey, Faker::Quote.jack_handey],
          goals: Faker::TvShows::Friends.quote,
          style: Faker::Music.genre,
          action_steps: Faker::Quote.famous_last_words
        )
        end

        expect(page).to have_content("Collection of Ideas")
        expect(@artist1.artist_files.count).to eq(3)

        expect(page).to have_content(@artist1.artist_files.first.goals)
        expect(page).to have_content(@artist1.artist_files.first.action_steps)
        expect(page).to have_content("Resources:")
      end

      it "changes when adding more artist files >4" do
        5.times do @artist1.artist_files.create!(
          image_url: Faker::LoremFlickr.image,
          resources: [Faker::Quote.jack_handey, Faker::Quote.jack_handey, Faker::Quote.jack_handey],
          goals: Faker::TvShows::Friends.quote,
          style: Faker::Music.genre,
          action_steps: Faker::Quote.famous_last_words
        )
        end
        
        visit artist_path(@artist1)
        expect(page).to have_content("Collection of Ideas")
        expect(@artist1.artist_files.count).to eq(6)

        expect(page).to_not have_content(@artist1.artist_files.first.goals)
        expect(page).to_not have_content(@artist1.artist_files.first.action_steps)
        expect(page).to_not have_content("Resources:")
      end
    end
  end
end