

10.times do
  artist = Artist.create!(
    name: Faker::Artist.name,
    email: Faker::Internet.email,
    style: Faker::Music.genre,
    bio: Faker::TvShows::MichaelScott.quote,
    password: "password"
  )
end