module FastSpring
  class LocalizedStorePricing < PublicApiBase
    # Get the localized store pricing from Saasy
    def find
      # For some reason the implicit determination of the Txt parser does not work.
      # So we'll just blatently pass it in right now.
      @response = self.class.get(base_localized_store_pricing_path, :query => query)
      @builder = Build::LocalizedStorePrices.new(@response.parsed_response).build
      self
    end

    def base_localized_store_pricing_path
      "/#{@company}/api/price"
    end

    def query
      query_hash = Hash.new
      @product_paths.each_index{ |index| query_hash["product_#{(index + 1)}_path".to_sym] = @product_paths[index] }
      query_hash.merge({
        :user_remote_addr => @remote_ip,
        :user_accept_language => @http_accept_language,
        :user_x_forwarded_for => @http_x_forwarded_for
      })
    end

    def user_country
      @builder.localized_pricing['user_country']
    end

    def user_language
      @builder.localized_pricing['user_language']
    end

    def user_currency
      @builder.localized_pricing['user_currency']
    end

    def product_quantity(product_path)
      product(product_path).quantity
    end

    def product_unit_value(product_path)
      product(product_path).unit_value
    end

    def product_unit_currency(product_path)
      product(product_path).unit_currency
    end

    def product_unit_display(product_path)
      product(product_path).unit_display
    end

    def product_unit_html(product_path)
      product(product_path).unit_html
    end

    def product(product_path)
      @builder.products.select { |product| product.path == product_path }.first
    end
  end
end
