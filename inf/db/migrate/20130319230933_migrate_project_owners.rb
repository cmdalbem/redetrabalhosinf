class MigrateProjectOwners < ActiveRecord::Migration
  def up
  	Project.all.each do |p|
  		p.people.push(p.person)
  	end
  end

  def down
  	Project.all.each do |p|
  		p.people = []
  	end
  end
end
