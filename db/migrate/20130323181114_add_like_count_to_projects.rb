class AddLikeCountToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :likeCount, :integer
  end
end
