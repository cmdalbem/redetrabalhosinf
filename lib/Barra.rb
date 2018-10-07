module Types

	class Barra

		attr_accessor :year, :semester
		def initialize(year, semester)
		  @year = year
		  @semester = semester
		end

		def initialize(barra)
			tmp = barra.split("/")
			@year = tmp[0]
			@semester = tmp[1]
		end

		def to_s
			year.to_s + "/" + semester.to_s;
		end
	end

end