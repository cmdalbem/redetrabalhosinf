class ChangeStringTypeToText < ActiveRecord::Migration
  def up
  	change_column :projects, :description, :text, :limit => nil
  	change_column :people, :about, :text, :limit => nil  	
  end

  def down
  	change_column :projects, :description, :string
  	change_column :people, :about, :text, :string
  end
end
