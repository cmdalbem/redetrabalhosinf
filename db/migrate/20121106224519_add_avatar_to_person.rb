class AddAvatarToPerson < ActiveRecord::Migration
 def self.up
    add_attachment :people, :avatar
  end

  def self.down
    remove_attachment :people, :avatar
  end
end
