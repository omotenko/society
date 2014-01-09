class String
	@@i = 0
	def self.convert_from_sh2(str)
		File.readlines("F:\\RailsInstaller\\password.txt").each do |s|
		    @mas = s.split(" - ")
		    return @mas[0] if (@mas[1] <=> str).zero?
		end 
	end
end