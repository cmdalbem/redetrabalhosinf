class AddTagsStrToProject < ActiveRecord::Migration
  def up
    add_column :projects, :tags_str, :text

    Project.all.each do |p|
    	tags = []
    	p.tags.each { |t| tags << t.tag_text }
    	p.update_attribute(:tags_str,tags.join(" "))
    end

  end

  def down
  	remove_column :projects, :tags_str
  end
end
