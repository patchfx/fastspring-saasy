module FastSpring
  class PublicApiBase
    include HTTParty
    base_uri 'http://sites.fastspring.com'

    def initialize(product_paths, http_request)
      @company = FastSpring::Account.fetch(:company)
      @product_paths = product_paths
      @remote_ip = http_request.respond_to?(:remote_ip) ? http_request.remote_ip : "127.0.0.1"
      @http_accept_language = http_request.respond_to?(:env) ? http_request.env["HTTP_ACCEPT_LANGUAGE"] : "en"
      @http_x_forwarded_for = http_request.respond_to?(:env) ? http_request.env["HTTP_X_FORWARDED_FOR"] : ""
    end

    def self.find(product_path, http_request)
      self.new(product_path, http_request).find
    end
  end
end
