require 'open-uri'
require 'net/http'

# Default parameters 
how_many = 1
mode = 'p'

# Set Arguments if they exist
how_many_arg = ARGV[0] if !ARGV[0].empty?
how_many = how_many_arg.to_i if !how_many_arg.nil?

mode_arg = ARGV[1] if !ARGV[1].empty?
mode = mode_arg.to_s if !mode_arg.nil?


# Set parameters for freeformatter 
params = {
	'site' => 'lorem-ipsum', 
	'mode' => "#{mode}", 
	'howMany' => "#{how_many}",
	'size' => 'SMALL', 
	'includeHtml' => 'false' 
}

# Post and set content
url = URI.parse('http://www.freeformatter.com/lorem-ipsum-generator.html')
resp = Net::HTTP.post_form(url, params)
content = resp.body
content = resp.body.gsub(/<\/\li>/, "\n").gsub(/<\/?[^>]*>/, "") if mode == 'l'

# Return content
puts content
