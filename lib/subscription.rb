module FastSpring
  class Subscription
    attr_reader :company_id

    def initialize(company_id)
      @company_id = company_id
    end
  end
end
