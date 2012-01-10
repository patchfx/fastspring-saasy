module FastSpring
  class LocalizedStorePricing < PublicApiBase
    # Get the localized store pricing from Saasy
    def find
      # For some reason the implicit determination of the Txt parser does not work.
      # So we'll just blatently pass it in right now.
      @response = self.class.get(base_localized_store_pricing_path, :query => query, :parser => Parser::Txt)
      self
    end
    
    def base_localized_store_pricing_path
      "/#{@company}/api/price"
    end
    
    def query
      query_hash = Hash.new
      @product_paths.each_index{ |index| query_hash["product_#{(index + 1)}_path".to_sym] = @product_paths[index] }
      query_hash.merge({ 
        :user_remote_addr => @remote_ip,
        :user_accept_language => @http_accept_language,
        :user_x_forwarded_for => @http_x_forwarded_for
      })
    end
    
    def user_country
      parsed_response['user_country']
    end
    
    def user_language
      parsed_response['user_language']
    end
    
    def user_currency
      parsed_response['user_currency']
    end
    
    def product_quantity(product_path)
      parsed_response[product_path]["quantity"]
    end
    
    def product_unit_value(product_path)
      parsed_response[product_path]["unit_value"]
    end
    
    def product_unit_currency(product_path)
      parsed_response[product_path]["unit_currency"]
    end
    
    def product_unit_display(product_path)
      parsed_response[product_path]["unit_display"]
    end
    
    def product_unit_html(product_path)
      parsed_response[product_path]["unit_html"]
    end


    protected
    
    def parsed_response
      @parsed_response ||= parse_response
    end
    
    def parse_response
      response = Hash.new

      index = 1
      more_products = true
      while more_products
        product_path = @response.parsed_response["product_#{index}_path"]
        if product_path
          @response.parsed_response.each do |key, value| 
            if key.match("product_#{index}") && key != "product_#{index}_path" then
              response[product_path] ||= Hash.new
              response[product_path][key.match(/\d+_(.*)/)[1]] = value
            end
          end
          index += 1
        else
          more_products = false
        end
      end

      response.merge(
        @response.parsed_response.reject{ |key, value| key.match(/^product_/) }
      )
    end
  end
end
