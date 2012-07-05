class ChangeUserIdToInt < ActiveRecord::Migration
  # moved to 
  def up
    #change_column :photos, :user_id, :integer
  end

  def down
    #change_column :photos, :user_id, :string
  end
end
