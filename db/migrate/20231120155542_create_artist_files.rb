class CreateArtistFiles < ActiveRecord::Migration[7.0]
  def change
    create_table :artist_files do |t|
      t.string :topic
      t.string :image_url
      t.string :resources
      t.string :goals
      t.string :action_steps

      t.timestamps
    end
  end
end
