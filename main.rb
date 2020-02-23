require 'open3'
require 'colorize'
require_relative 'lib/commands'
require_relative 'lib/utils'
require_relative 'lib/crypto'

print"

████████╗██╗  ██╗███████╗    ██╗      ██████╗  ██████╗ ██╗  ██╗███████╗██████╗
╚══██╔══╝██║  ██║██╔════╝    ██║     ██╔═══██╗██╔═══██╗██║ ██╔╝██╔════╝██╔══██╗
   ██║   ███████║█████╗      ██║     ██║   ██║██║   ██║█████╔╝ █████╗  ██████╔╝
   ██║   ██╔══██║██╔══╝      ██║     ██║   ██║██║   ██║██╔═██╗ ██╔══╝  ██╔══██╗
   ██║   ██║  ██║███████╗    ███████╗╚██████╔╝╚██████╔╝██║  ██╗███████╗██║  ██║
   ╚═╝   ╚═╝  ╚═╝╚══════╝    ╚══════╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝

".red
print("Looker>".green)
opt = gets.chomp.split
case opt[0]
when "run"
    if opt[1].nil?
    	puts "use file"
    end
    Commands.file_command(opt[1])
    Commands.strings_command(opt[1])
    Commands.detect_urls(opt[1])
    Commands.detect_strings(opt[1])
    Commands.hash_file(opt[1])
    Crypto.detect_monero(opt[1])
    #Crypto.detect_base64(opt[1])
end