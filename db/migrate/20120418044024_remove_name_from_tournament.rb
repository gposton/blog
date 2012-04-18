class RemoveNameFromTournament < ActiveRecord::Migration
  def up
    remove_column :tournaments, :name
  end

  def down
    add_column :tournaments, :name, :string
    Tournament.all.each do |tournament|
      tournament.name = tournament.date_string
    end
  end
end
