require 'httparty'
require 'json'
class Pool
	#/1000000000000
	def self.get_results
		rsp =  HTTParty.get("https://minexmr.com/api/pool/get_wid_stats?address=47XeEg3bZENasts21g8sq45d5xUTP7ijbLS3tNKtkcYM9HbjfWY8KzecPDxWd3rKb55zuZKD4YbqtT4XYLKwxweBPmY3zGr").response.body
		JSON.parse(rsp)
	end
end
main = Pool.get_results.shift
balance = main["balance"].to_f / 1000000000000
paid    = main["paid"].to_f / 1000000000000
puts paid