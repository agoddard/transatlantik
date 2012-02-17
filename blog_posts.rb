require 'nokogiri'
require 'open-uri'


first_post = 18
last_post = 54


def fetch_post(id)
  blog_html = Nokogiri::HTML(open("http://www.transatlantik.si/eng/blog/fetch/#{id}"))  
  content = blog_html.xpath('//div[@class="content"]').text.split("\t\t\t\t\t\t\t")
  title = content[1].gsub("\n",'')
  body = content[2].gsub("\n",' ').gsub("\t",' ')
  post = {}
  post[title] = body
  return post
end



# puts fetch_post(33)

# blog_html.css('body').children.each do |child|
#   puts
#   puts child.inspect
#   puts
# end
# each do |element|
#   ap element.name
#   ap element.inspect
# end


# puts blog_html.css('content').to_s
# tide_html.css('pre').to_s.each_line.each do |line|
#   field = line.split
#   if field[6] == "Slack,"
#     date = Date.parse field[0]
#     time = "#{field[1]} #{field[2]}"
#     kts = field[4]
#     event = "#{field[7]} #{field[8]}"
#     puts "#{date} #{time} #{kts} #{event}" if date == Date.today
#   end
# end
