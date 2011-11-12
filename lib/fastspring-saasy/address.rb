module FastSpring
  class Address
    attr_reader :address_line_1, :address_line_2, :city, :region,
                :region_custom, :postal_code, :country

    def initialize(options)
      @address_line_1 = options.fetch('addressLine1')
      @address_line_2 = options.fetch('addressLine2')
      @city = options.fetch('city')
      @region = options.fetch('region')
      @region_custom = options.fetch('regionCustom')
      @postal_code = options.fetch('postalCode')
      @country = options.fetch('country')
    end
  end
end
