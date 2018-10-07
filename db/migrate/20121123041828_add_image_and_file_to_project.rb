class AddImageAndFileToProject < ActiveRecord::Migration
 def self.up
    add_attachment :projects, :image
    add_attachment :projects, :file
  end

  def self.down
    remove_attachment :projects, :image
    remove_attachment :projects, :file
  end
end
