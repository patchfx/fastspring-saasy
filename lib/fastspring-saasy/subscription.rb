require 'date'

module FastSpring
  class Subscription < Base

    # Find a subscription by reference
    def self.find(reference)
      subscription = self.new(reference)
      subscription.find
      subscription
    end

    # Get the subscription from Saasy
    def find
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

    # When the status was last changed
    def status_changed
      DateTime.parse(value_for('statusChanged'))
    end

    # The reason for a status change
    def status_reason
      value_for('statusReason')
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

    # Subscription product name
    def product_name
      value_for('productName')
    end

    def next_period_date
      Date.parse(value_for('nextPeriodDate'))
    end

    # The date the subscription ends on
    def ends_on
      Date.parse(value_for('end'))
    end

    # Returns a customer object
    def customer
      @customer ||= Customer.new(value_for('customer'))
    end

    # Cancel the subscription
    def destroy
      self.class.delete(base_subscription_path, :basic_auth => @auth)
    end

    def renew_path
      "#{base_subscription_path}/renew"
    end

    # Renew the subscription
    def renew
      self.class.post(renew_path, :basic_auth => @auth)
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

