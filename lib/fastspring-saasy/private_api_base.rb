module FastSpring
  class PrivateApiBase
    include HTTParty
    base_uri "https://api.fastspring.com"
    format :xml
    #debug_output

    attr_reader :customer

    def initialize(reference)
      @auth = {:username => FastSpring::Account.fetch(:username),
              :password => FastSpring::Account.fetch(:password)}
      @company = FastSpring::Account.fetch(:company)
      @reference = reference
      @ssl_ca_file = FastSpring::Account.fetch(:ssl_ca_file)
    end

    def self.find(reference)
      self.new(reference).find
    end

    def self.search(query="")
      self.new("").search(query)
    end

    def search(query)
      response = self.class.get("/company/#{@company}/orders/search?query=#{CGI::escape(query)}", :basic_auth => @auth, :ssl_ca_file => @ssl_ca_file)
      order_response = response.parsed_response['orders']['order']
      return [] if order_response.nil?

      order_response.map do |order|
        Order.new("").build_from(order)
      end
    end

    def reference
      @reference
    end

    # Returns the current status
    def status
      value_for('status')
    end

    # When the status was last changed
    def status_changed
      DateTime.parse(value_for('statusChanged'))
    end

    def referrer
      value_for('referrer')
    end

    def source_name
      value_for('sourceName')
    end

    def source_key
      value_for('sourceKey')
    end

    def source_campaign
      value_for('sourceCampaign')
    end

    # Returns a customer object
    def customer
      @customer ||= Customer.new(value_for('customer'))
    end

    private
    def value_for(attribute)
      parsed_response.fetch(attribute)
    end
  end
end
