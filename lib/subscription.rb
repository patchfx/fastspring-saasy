require File.expand_path(File.join(File.dirname(__FILE__), 'customer.rb'))
require 'httparty'
module FastSpring
  class Subscription
    include HTTParty
    base_uri 'https://api.fastspring.com'
    format :xml
    #debug_output

    attr_reader :customer

    # Get the subscription from Saasy
    def initialize(company, reference, username, password)
      @auth = {:username => username, :password => password}
      @company = company
      @reference = reference
      @response = self.class.get(base_subscription_path, :basic_auth => @auth)
    end

    # Returns the base path for a subscription
    def base_subscription_path
      "/company/#{@company}/subscription/#{@reference}"
    end

    # Subscription status
    def status
      value_for('status')
    end

    # Is the subscription active?
    def active?
      status == 'active'
    end

    # Can the subscription be cancelled?
    def cancelable?
      value_for('cancelable') == 'true'
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

    def parsed_response
      @response.parsed_response['subscription']
    end

    def value_for(attribute)
      parsed_response.fetch(attribute)
    end

  end
end
