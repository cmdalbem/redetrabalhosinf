class Course < ActiveRecord::Base
	has_many :projects

	validates :name, presence: true
	validates :code, uniqueness: true

	def self.search(search)
		search.downcase!
		if search
			query = []
			params = []
			# Creates queries for each word of the input, and then join them with ANDs.
			words = search.split(" ")
			words.size.times do |i|
				query << "(name ILIKE :w#{i} OR code ILIKE :w#{i})"
				params << [:"w#{i}", "%#{words[i]}%"]
			end
			query = query.join(" AND ")

			where(query, Hash[params])
		else
			scoped
		end
	end	

end
