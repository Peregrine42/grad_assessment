require './lib/chainlink'

begin
  result = Chainlink.new.walk ARGV[0], ARGV[1], ARGV[2]
rescue ChainlinkException => e
  abort e.message
end

result.each do |line|
  puts line
end
