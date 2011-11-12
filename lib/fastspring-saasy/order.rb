module FastSpring
  class Order < Base
    # Get the order from Saasy
    def find
      @response = self.class.get(base_order_path, :basic_auth => @auth)
      self
    end

    def base_order_path
      "/company/#{@company}/order/#{@reference}"
    end

    private

    def parsed_response
      @response.parsed_response['order']
    end

  end
end
