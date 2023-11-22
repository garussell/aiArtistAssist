class AddEmailToArtists < ActiveRecord::Migration[7.0]
  def change
    add_column :artists, :email, :string
  end
end
