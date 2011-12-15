class ParseTxt
  include HTTParty

  # Replace the :plain parser with this text parser
  class Parser::Txt < HTTParty::Parser
    SupportedFormats["text/plain"] = :txt

    # perform text parsing on body
    def txt
      parsed_response = Hash.new
      body.each_line do |line| 
        name_value = line.split("=")
        parsed_response[name_value[0].strip] = name_value[1].strip if name_value.count == 2
      end
      parsed_response
    end
  end
  
  parser Parser::Txt
end