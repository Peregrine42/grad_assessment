require './lib/chainlink'

result = Chainlink.new.walk ARGV[0], ARGV[1], ARGV[2]
result.each do |line|
  puts line
end
