class AddLinkHitCountToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :linkHitCount, :integer, default: 0

  end
end
