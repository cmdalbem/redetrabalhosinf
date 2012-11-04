class Tag < ActiveRecord::Base
	has_many :taggings
	has_many :projects, through: :taggings

	def as_json()
	  { :id => self.id, :name => self.tag_text }
	end
end
