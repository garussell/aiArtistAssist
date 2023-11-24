

10.times do
  artist = Artist.create!(
    name: Faker::Artist.name,
    email: Faker::Internet.email,
    style: Faker::Music.genre,
    bio: Faker::TvShows::MichaelScott.quote,
    password: "password"
  )
  puts "Artist #{artist.id} created"

  3.times do
    artist.artist_files.create!(
      image_url: Faker::LoremFlickr.image,
      resources: [Faker::Quote.jack_handey, Faker::Quote.jack_handey, Faker::Quote.jack_handey],
      goals: Faker::TvShows::Friends.quote,
      action_steps: Faker::Quote.famous_last_words
    )
  end

  puts "3 artist files created for artist #{artist.id}"
end

puts
puts "Seed finished"
puts "10 artists created with 3 artist files each"