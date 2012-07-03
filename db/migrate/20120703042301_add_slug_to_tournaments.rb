class AddSlugToTournaments < ActiveRecord::Migration
  def change
    add_column :tournaments, :slug, :string
    Tournament.find_each(&:save)
  end
end
