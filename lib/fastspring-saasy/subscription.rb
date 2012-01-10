require 'date'

module FastSpring
  class Subscription < PrivateApiBase

    # Get the subscription from Saasy
    def find
      @response = self.class.get(base_subscription_path, :basic_auth => @auth)
      self
    end

    # Returns the base path for a subscription
    def base_subscription_path
      "/company/#{@company}/subscription/#{@reference}"
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

  end
end

