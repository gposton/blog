class CreateStates < ActiveRecord::Migration
  def self.up
    create_table :states do |t|
      t.string :name

      t.timestamps
    end
    %w(scheduled open closed).each do |state|
      State.create(:name => state)
    end
    add_column :tournaments, :state_id, :integer, :default => 1
  end

  def self.down
    drop_table :states
    remove_column :tournaments, :state_id
  end
end
