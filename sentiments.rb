require './sentiment.rb'
require './blog_posts.rb'

(18..58).each do |id|
  result = analyze_sentiment(fetch_post(id).to_s)
  puts "#{id} result: #{result}"
  case result
  when 0
    puts "negative"
  when 1
    puts "neutral"
  when 2
    puts "positive"
  end

end

