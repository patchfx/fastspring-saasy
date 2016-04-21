module FastSpring
  module Build
    class LocalizedStorePrices
      attr_reader :localized_pricing, :products

      def initialize(pricing)
        @pricing = pricing || []
        @products = []
        @localized_pricing = {}
      end

      def build
        return if @pricing.empty?
        parsed = @pricing.split("\n").map { |f| f.split("=") }
        @localized_pricing = Hash[parsed]
        build_products
        self
      end

      private

      def build_products
        product_names = []
        @localized_pricing.keys.each do |key|
          product = /product_[0-9]/.match(key)
          product_names << product.to_s unless product.nil?
        end
        create_localized_products_for(product_names.uniq)
      end

      def create_localized_products_for(product_names)
        product_names.each do |product|
          keys = @localized_pricing.select { |key, value| key.to_s.match(/#{product}/) }
          @products << LocalizedStorePrice.new(product, keys)
        end
      end
    end
  end
end
