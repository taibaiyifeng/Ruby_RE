require 'open3'
require 'digest/md5'
require 'fileutils'
require 'uri'
require_relative 'utils'
class Commands
	def self.file_command(file_name)
		# Runs the file command. If the output includes the word dynamic. It will also run
		# ldd on the file
		stdout, stderr, status = Open3.capture3("file #{file_name}")
		if stdout.include?("dynamic")
			puts "[-] Detected that the binary is dynamic. Running ldd."
			stdout, stderr, status = Open3.capture3("ldd #{file_name} > #{File.join("lists", "ldd.txt")}")
			Utils.save_file(file_name, "[Ldd]\n Running ldd.. Saved output to #{File.join("lists", "ldd.txt")}\n")
		else
			Utils.save_file("#{file_name}", "[ FILE ]\n#{stdout}\n")
		end
	end
	def self.hash_file(file_name)
		# Get the file hash
		 md5 = Digest::MD5.hexdigest(File.read(file_name))
		 Utils.save_file(file_name, "[ FILE HASH ]\n MD5: #{md5}\n")
	end
	def self.strings_command(file_name)
		# Runs the string command. Save output to strings.txt
		stdout, stderr, status =  Open3.capture3("strings #{file_name} > #{File.join("output", file_name, "strings.txt")}")
	end
	def self.detect_urls(file_name)
		output = ""
		stdout1, stderr, status =  Open3.capture3('grep -E -o "(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)"' + " #{file_name}")
		stdout2, stderr, status =  Open3.capture3("cat #{ file_name} " + '| grep -Eo "(http|https)://[a-zA-Z0-9./?=_-]*" | sort -u')
		output += stdout1 + "\n" + stdout2
		Utils.save_file(file_name, "[ URLS & IPS ]\n #{output}\n")
	end
	def self.detect_strings(file_name)
		# Checks the output of the strings commands for intresting strings.
		text = File.read(File.join("output", file_name, "strings.txt")).to_s
		keywords = File.read(File.join("lists", "strings.txt"))
		output = ""
		File.open("lists/strings.txt").each_line do |z|
			if text.include?(z.strip)
				output += z + "\n"
			end
		end
	Utils.save_file(file_name, "[ INTRESTING STRINGS ]\n #{output}\n")
	end
end
#Commands.detect_strings("w.txt")