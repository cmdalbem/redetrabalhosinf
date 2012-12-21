class ChangeCommentStringTypeToText < ActiveRecord::Migration
  def up
  	change_column :comments, :text, :text, :limit => nil 
  end

  def down
  	change_column :comments, :text, :string
  end
end
