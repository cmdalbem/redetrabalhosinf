class AddPersonIndexToProject < ActiveRecord::Migration
  def change
	add_column :projects, :person_id, :integer
  	add_index :projects, :person_id
  end
end
