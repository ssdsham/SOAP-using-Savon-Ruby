require 'savon'
require 'nokogiri'
require 'CSV'

load "../lib/insbridge_process_request.rb"


##########################################
# Function for insbridge_process_request #
##########################################

insbridgeInputFiles = Array.new

Dir["../inputForSoap/*.xml"].each do |s|
	insbridgeInputFiles.push s       							
end

insbridgeInputFiles.each do |fileName|
	curFile = fileName.strip
	file_name = fileName[/([^:\\\/]*?)(?:\.([^ :\\\/.]*))?$/][$1] 
	puts "Sending #{file_name} to Insbridge"
	inputToSoap = File.read(curFile).gsub("&gt;",">").gsub("&lt;","<")
		
	client = Savon.client(wsdl: "replace wsdl end point here")
	result = func_callInsbridge(inputToSoap,client)
	
	result = result.to_s.gsub("&gt;",">")
	result = result.gsub("&lt;","<")
	puts "Saving response XML for  #{file_name}\n\n"
	output_file = File.open("../inputForXMLParser/#{file_name}.xml","w")
	output_file.puts result
	output_file.close
end



##########################################
# Function for XML Parsing				 #
##########################################


XMLParserInputFiles = Array.new

Dir["../inputForXMLParser/*.xml"].each do |s|
	XMLParserInputFiles.push s       											
end

XMLParserInputFiles.each do |fileName|
	func_XMLParser(fileName)
end