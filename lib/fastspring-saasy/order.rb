module FastSpring
  class Order < Base
    attr_reader :purchaser
    # Get the order from Saasy
    def find
      @response = self.class.get(base_order_path, :basic_auth => @auth)
      self
    end

    def base_order_path
      "/company/#{@company}/order/#{@reference}"
    end

    # Return the order reference
    def reference
      value_for('reference')
    end

    # Was the order a test?
    def test?
      value_for('test') == 'true'
    end

    # Returns a DateTime object
    def due
      DateTime.parse(value_for('due'))
    end

    def currency
      value_for('currency')
    end

    def origin_ip
      value_for('originIp')
    end

    def purchaser
      @purchaser ||= Customer.new(value_for('customer'))
    end

    def total
      value_for('total').to_f
    end

    def tax
      value_for('tax').to_f
    end

    def shipping
      value_for('shipping').to_f
    end

    def address
      @address ||= Address.new(value_for('address'))
    end

    private

    def parsed_response
      @response.parsed_response['order']
    end

  end
end
