class Tag < ActiveRecord::Base
	has_many :taggings, dependent: :destroy
	has_many :projects, through: :taggings

	validates :tag_text, presence: true

	# JSON formatting used for feeding the TokenInput Plugin autocomplete feature.
	def as_json()
	  { :id => self.id, :name => self.tag_text }
	end
end
