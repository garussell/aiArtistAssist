class CreateArtists < ActiveRecord::Migration[7.0]
  def change
    create_table :artists do |t|
      t.string :name
      t.string :style
      t.text :bio
      t.string :password_digest

      t.timestamps
    end
  end
end
