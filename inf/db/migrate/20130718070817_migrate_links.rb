class MigrateLinks < ActiveRecord::Migration
  def up
  	Project.all.each do |p| 
  		if not p.link.blank?
  			p.links << Link.create(url: p.link, hits: p.linkHitCount)
  		end
  	end
  end

  def down
	Project.all.each do |p| 
		p.links.destroy_all
	end
  end
end
