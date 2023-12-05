class AddStyleToArtistFiles < ActiveRecord::Migration[7.0]
  def change
    add_column :artist_files, :style, :string
  end
end
