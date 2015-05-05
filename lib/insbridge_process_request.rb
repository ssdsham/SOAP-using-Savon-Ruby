##################################################################################
# Script Name  : insbridge_process_request.rb                                    #
# Description  : Make a call to insbridge										 #
# Author       : Sham Dorairaj                                                   #
# Version      : v1.0                                                            #
##################################################################################

# Function to make a insbridge call - uses two input parameters - an input xml and the client WSDL
# =======================================================================================================

def func_callInsbridge(inputxml,client)
begin 	
		response = client.call(:process_request, message: {
						 "aXMLInput" => inputxml,
						 "aAddRoot" => "1",
						 "aAddInputs" => "1",
						 "aAddHeading" => "1"
				  } )
end	
		return response
end

# Once the client is constructed. We can make a call and save the result to output.xml
# =======================================================================================================
