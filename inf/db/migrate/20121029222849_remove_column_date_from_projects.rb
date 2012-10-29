class RemoveColumnDateFromProjects < ActiveRecord::Migration
  def up
    remove_column :projects, :date
      end

  def down
    add_column :projects, :date, :datetime
  end
end
