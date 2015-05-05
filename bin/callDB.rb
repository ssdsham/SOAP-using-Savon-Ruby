##################################################################################
# Script Name  : callDB.rb                                          	         #
# Description  : Make a DB call to the oracle server to run a SQL				 #
# Author       : Sham Dorairaj                                                   #
# Version      : v1.0                                                            #
# Date         : 02/16/2015                                                      #
##################################################################################


require 'dbi'
require 'nokogiri'
require 'rubygems'
require 'yaml'
require 'thread'
require 'thwait'
require 'yaml'


configuration = YAML.load_file "configuration.yaml"

 
outdir="../inputForSoap"
counter=0
DATABASE_NAME=configuration.fetch("DATABASE_NAME")
USER_NAME=configuration.fetch("USER_NAME")
PASSWORD=configuration.fetch("PASSWORD")

 
 DBI.connect('DATABASE_NAME','USER_NAME','PASSWORD') do |dbh|
	 
	    dbh.prepare("SQL TO BE EXECUTED" ) do |sth|
		header = File.read("config\\header.xml")
		tail = File.read("config\\tail.xml")				
        sth.execute()
		sth.each do |row|	
 
				inputXml = row[0]
				str_inputXML =  Nokogiri::XML(inputXml.read(0)) 
				infile="internetRespxmlFromDB_#{counter}.xml"
				#result = header + contents + tail
				result = str_inputXML.to_s
				result = result.gsub("\n",'') 
				 result = result.gsub("&gt;",'>')
			    result = result.gsub("&lt;",'<')
				File.open("#{outdir}\\#{infile}","w") {|f| f.write(result) }				
				counter=counter+1			
				p infile
        end
     end
   end