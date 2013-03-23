class SetLikeCountsInProjects < ActiveRecord::Migration
  def up
  	Project.all.each do |p|
  		p.update_attribute(:likeCount,p.likes.count)
  	end
  end

  def down
  end
end
