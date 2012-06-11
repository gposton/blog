class AddAlbums < ActiveRecord::Migration
  def up
    create_table :albums do |t|
      t.string :name

      t.timestamps
    end
    add_column :photos, :album_id, :integer
    album = Album.create :name => 'New'
    Photo.all.each do |photo|
      photo.update_attributes :album_id => album.id
    end
  end

  def down
    remove_column :photos, :album_id
    drop_table :albums
  end
end
