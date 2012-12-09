class Tag < ActiveRecord::Base
	has_many :taggings
	has_many :projects, through: :taggings

	validates :tag_text, presence: true

	def as_json()
	  { :id => self.id, :name => self.tag_text }
	end
end
