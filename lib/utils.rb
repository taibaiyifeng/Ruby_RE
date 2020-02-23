require_relative 'commands'
class Utils
	def self.save_file(file_name, output)
		# saves the out put into the file. 
		FileUtils.mkdir_p(File.join("output", file_name))  unless File.exists?(File.join("output", file_name))
		f = File.open(File.join("output", file_name, file_name + ".txt"), "a")
		f.write(output)
		f.close
	end
	def self.detect(file_name, regex, header)
		list = []
		File.readlines(File.join("output", file_name, "strings.txt")).each do |line|
			if line.match(/#{regex}/)
				list << line
			end
		end
		p list
		Utils.save_file(file_name, "\n[ #{header} ]\n #{list.shift}") if !list.empty?
	end
end

