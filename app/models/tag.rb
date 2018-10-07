class Tag < ActiveRecord::Base
	has_many :taggings, dependent: :destroy
	has_many :projects, through: :taggings

	validates :tag_text, presence: true, uniqueness: true

	def as_json()
	  { :id => self.id, :name => self.tag_text }
	end

	def self.search(search)
		search.downcase!
		if search
			query = []
			params = []
			# Creates queries for each word of the input, and then join them with ANDs.
			words = search.split(" ")
			words.size.times do |i|
				query << "(tag_text ILIKE :w#{i})"
				params << [:"w#{i}", "%#{words[i]}%"]
			end
			query = query.join(" OR ")

			where(query, Hash[params])
		else
			scoped
		end
	end	

end
