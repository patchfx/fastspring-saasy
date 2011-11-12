module FastSpring
  class Item
    attr_reader :product_display, :product_name, :quantity, :subscription_reference
    def initialize(details)
      @product_display = details.fetch('productDisplay')
      @product_name = details.fetch('productName')
      @quantity = details.fetch('quantity')
      @subscription_reference = details.fetch('subscriptionReference')
    end
  end
end
