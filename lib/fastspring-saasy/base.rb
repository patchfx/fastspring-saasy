module FastSpring
  class Base
    include HTTParty
    base_uri 'https://api.fastspring.com'
    format :xml
    #debug_output

    attr_reader :customer

    def initialize(reference)
      @auth = {:username => FastSpring::Account.fetch(:username), 
              :password => FastSpring::Account.fetch(:password)}
      @company = FastSpring::Account.fetch(:company)
      @reference = reference
    end

  end
end
