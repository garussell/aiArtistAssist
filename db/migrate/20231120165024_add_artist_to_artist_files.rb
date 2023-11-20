class AddArtistToArtistFiles < ActiveRecord::Migration[7.0]
  def change
    add_reference :artist_files, :artist, null: false, foreign_key: true
  end
end
