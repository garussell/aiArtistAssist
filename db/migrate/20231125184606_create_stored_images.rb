class CreateStoredImages < ActiveRecord::Migration[7.0]
  def change
    create_table :stored_images do |t|
      t.references :artist_file, foreign_key: true
      t.references :image, foreign_key: { to_table: :active_storage_attachments }
      t.timestamps
    end
  end
end
