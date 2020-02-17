require_relative '../utils'
class Web
	def self.detect_ip(file_name)
		# Uses regex to match IPS
		ip = ""
		File.readlines(File.join("output", file_name, "strings.txt")).each do |line|
			if line.match(%r{\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b})
				ip += line.match(%r{\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b})[0] 
				ip += "\n"
			end
		end
		# save the output to the file
		Utils.save_file(file_name, "\n[ IP ADDRESSES ]\n #{ip}") if !ip.empty?
	end
	def self.detect_urls(file_name)
		Utils.detect(file_name, "strings.txt", %r{(?:(?:https?|ftp):\/\/|\b(?:[a-z\d]+\.))(?:(?:[^\s()<>]+|\((?:[^\s()<>]+|(?:\([^\s()<>]+\)))?\))+(?:\((?:[^\s()<>]+|(?:\(?:[^\s()<>]+\)))?\)|[^\s`!()\[\]{};:'".,<>?«»“”‘’]))?} , "URLS")
	end
end

