class RemoveTournamentState < ActiveRecord::Migration
  def up
    remove_column :tournaments, :state_id
    drop_table :states
  end

  def down
    create_table :states do |t|
      t.string :name

      t.timestamps
    end
    %w(scheduled open closed).each do |state|
      State.create(:name => state)
    end
    add_column :tournaments, :state_id, :integer, :default => 1
  end
end
