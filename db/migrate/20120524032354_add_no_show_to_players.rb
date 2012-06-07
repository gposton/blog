class AddNoShowToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :no_show, :boolean
    Player.all.each do |p|
      p.no_show = false
      p.save
    end
  end
end
