class RemoveTopicFromArtistFiles < ActiveRecord::Migration[7.0]
  def change
    remove_column :artist_files, :topic, :string
  end
end
