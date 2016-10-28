require 'open-uri'
require 'net/http'
require 'json'

def set_params amount, what
	# Set parameters for lipsum.com 
	params = {
		'amount' => "#{amount}",
		'what' => "#{what}"
	}
end

def get_lipsum params
	url = URI.parse('http://www.lipsum.com/feed/json')
	resp = Net::HTTP.post_form(url, params)
	content = resp.body
end

def add_extra_spacing content
	# add extra spaces if string contains \n
	content.gsub! '\n', '\n\n' if content.include? '\n'
	content
end

def parse_content content
	content = JSON.parse(content)
	content["feed"]["lipsum"]
end

def remove_blah content
	content = resp.body.gsub(/<\/\li>/, "\n").gsub(/<\/?[^>]*>/, "") if what == 'l'
	content.strip
end

def prepare_content content
	spaced_content = add_extra_spacing content
	parse_content spaced_content
end

def return_content content
	print content
end

def generate_lipsum amount, what
	params = set_params amount, what
	raw_content = get_lipsum params
	content = prepare_content raw_content
	return_content content
end

def set_amount
	# Default arg
	amount = 1
	# Set Argument if they exist
	amount_arg = ARGV[0] if !ARGV[0].empty?
	amount = amount_arg.to_i if !amount_arg.nil?
	return amount
end

def set_mode
	# Default arg
	what = 'paras'
	# Set Argument if they exist
	what_arg = ARGV[1] if !ARGV[1].empty?
	what = what_arg.to_s if !what_arg.nil?
	return what
end

def init
	amount = set_amount
	what = set_mode
	generate_lipsum amount, what
end

init()