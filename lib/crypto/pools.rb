require 'httparty'
require 'json'
class Pool
	def self.mine_xmr(address)
		# get miner information from the mining pool
		rsp =  HTTParty.get("https://minexmr.com/api/pool/get_wid_stats?address=#{address}").response.body
		main = JSON.parse(rsp).shift
		# Divides so we can convert the results into a decminal 
		[ 
			main["balance"].to_f / 1000000000000,
			main["paid"].to_f / 1000000000000, 
			main['hashrate'], 
			"xmrmine.com", 
			"#{address}"  
		]
	end
	def self.nano_pool(address)
		rsp = HTTParty.get("https://api.nanopool.org/v1/xmr/user/#{address}").response.body
		main  = JSON.parse(rsp)
		# checking to make sure there are results
		if main["status"] != false || main["error"] != "Account not found"
			[
				main["data"]["balance"],
				main["data"]["unconfirmed_balance"],
				main["data"]["hashrate"]
			]
		end
	end
end

p Pool.nano_pool("44GzwxxapHVULNh8tnDZwtdFeQNsdNsSSLHpFJLZP7p39mcCgpnGnFdSDiYpWEKtvwLeGqrwmmW3bHBuP63JenhVMyCCAf8")