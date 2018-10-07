class AddUnreadToActivities < ActiveRecord::Migration
  def up
    add_column :activities, :unread, :boolean, default: true
  end

  def down
    remove_column :activities, :unread
  end
end
