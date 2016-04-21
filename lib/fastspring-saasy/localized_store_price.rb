module FastSpring
  class LocalizedStorePrice
    attr_reader :product

    def initialize(product, params)
      @product = product
      @params = params
    end

    def path
      fetch('path')
    end

    def quantity
      fetch('quantity')
    end

    def unit_value
      fetch('unit_value')
    end

    def unit_currency
      fetch('unit_currency')
    end

    def unit_display
      fetch('unit_display')
    end

    def unit_html
      fetch('unit_html')
    end

    def fetch(key)
      @params["#{product}_#{key}"]
    end
  end
end
