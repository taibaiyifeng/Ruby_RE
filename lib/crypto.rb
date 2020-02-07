require_relative 'utils'
class Crypto
	def self.detect_monero(file_name)
		#  use regex to match xmr address
		addresses = []
		File.readlines(File.join("output", file_name, "strings.txt")).each do |line|
			if line.match(/^4([0-9]|[A-B])(.){93}/)
				addresses << line
			end
		end
		Utils.save_file(file_name, "\n[ Monero ADDRESSES ]\n #{addresses.shift}") if !addresses.empty?
	end
	def self.detect_bitcoin(file_name)
		# use regex to match btc address
		# tbh prob could make it more efficent by making it one method that could check for a bunch of crypto wallets
		address = []
		File.readlines(File.join("output", file_name, "strings.txt")).each do |line|
			if line.match(/(?:[13][a-km-zA-HJ-NP-Z1-9]{25,34})/)
				addresses << line
			end
		Utils.save_file(file_name, "\n[ Bitcoin ADDRESSES ]\n #{addresses.shift}") if !addresses.empty?
		end
	end
	def self.detect_ssh(file_name)
		rsa = []
		File.readlines(File.join("output", file_name, "strinsg.txt")).each do |line|
			if line.match(/^(ssh-[a-z]{3}) ([0-9]{3,4}) ([0-9a-f]{2}:){15}[0-9a-f]{2}$/)
				rsa << line
			end
		Utils.save_file(file_name, "\n[ ssh-rsa ]\n #{rsa.shift}") if !rsa.empty?
		end
	end
end