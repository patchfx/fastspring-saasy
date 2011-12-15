module FastSpring
  class LocalizedStorePricing
    include HTTParty
    base_uri 'http://sites.fastspring.com'
    
    def initialize(product_path, remote_ip="", http_accept_language="en", http_x_forwarded_for="")
      @company = FastSpring::Account.fetch(:company)
      @product_path = product_path
      @remote_ip = remote_ip
      @http_accept_language = http_accept_language
      @http_x_forwarded_for = http_x_forwarded_for
    end

    def self.find(product_path, remote_ip="", http_accept_language="en", http_x_forwarded_for="")
      self.new(product_path, remote_ip, http_accept_language, http_x_forwarded_for).find
    end
    
    # Get the localized store pricing from Saasy
    def find
      @response = self.class.get(base_localized_store_pricing_path, :query => query)
      self
    end
    
    def base_localized_store_pricing_path
      "/#{@company}/api/price"
    end
    
    def query
      { 
        :product_1_path => @product_path,
        :user_remote_addr => @remote_ip,
        :user_x_forwarded_for => @http_accept_language,
        :user_accept_language => @http_x_forwarded_for
      }
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
    
    def product_path(index)
      parsed_response["product_#{index}_path"]
    end
    
    def product_quantity(index)
      parsed_response["product_#{index}_quantity"]
    end
    
    def product_unit_value(index)
      parsed_response["product_#{index}_unit_value"]
    end
    
    def product_unit_currency(index)
      parsed_response["product_#{index}_unit_currency"]
    end
    
    def product_unit_display(index)
      parsed_response["product_#{index}_unit_display"]
    end
    
    def product_unit_html(index)
      parsed_response["product_#{index}_unit_html"]
    end

    private
    
    def parsed_response
      # @formatted_response ||= formatted_response
      @response.parsed_response
    end
    
    def formatted_response
      formatted_response = Hash.new
      formatted_response["products"] = Array.new
      @response.parsed_response.each do |key, value|
        if key.start_with?("product")
          index = key.match(/(\d*)/)[0].to_i
          product_key = key.match(/_(\D*)$/)[0]
          
          formatted_response["products"][index] ||= Hash.new
          formatted_response["products"][index][product_key] = value
        else
          formatted_response[key] = value
        end
      end
      formatted_response
    end
  end
end
