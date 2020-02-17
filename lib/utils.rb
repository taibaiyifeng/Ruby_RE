require_relative 'commands'
class Utils
	def self.save_file(file_name, output)
		# saves the out put into the file. 
		FileUtils.mkdir_p(File.join("output", file_name))  unless File.exists?(File.join("output", file_name))
		f = File.open(File.join("output", file_name, file_name + ".txt"), "a")
		f.write(output)
		f.close
	end
	def self.detect(file_name_dir, file, regex, title)
		# file_name_dir = The file folder
		# file      = The file name we are reading 
		# Title the header of the file
		type = ""
		File.readlines(File.join("output", file_name_dir, file)).each do |line|
			if line.match(regex)
				type += line.match(regex)[0]
				type += "\n"
			end
		end
		type += "*NOTICE: It will detect alot of non urls. ITs the best regex I could find/create. Will fix later\n"
		Utils.save_file(file_name_dir, "\n#{title}\n #{type}") if !type.empty?
	end
end

