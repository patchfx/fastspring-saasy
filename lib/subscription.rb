require 'httparty'
module FastSpring
  class Subscription
    include HTTParty
    base_uri 'https://api.fastspring.com'
    format :xml
    #debug_output

    def initialize(company, reference, username, password)
      @auth = {:username => username, :password => password}
      @company = company
      @reference = reference
      @response = self.class.get(base_subscription_path, :basic_auth => @auth)
    end

    def base_subscription_path
      "/company/#{@company}/subscription/#{@reference}"
    end

    def value_for(attribute)
      parsed_response.fetch(attribute)
    end

    def status
      value_for('status')
    end

    def active?
      status == 'active'
    end

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

    private

    def parsed_response
      @response.parsed_response['subscription']
    end

  end
end
