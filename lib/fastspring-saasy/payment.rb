module FastSpring
  class Payment
    attr_reader :status, :status_changed, :method_type, :declined_reason,
                :currency, :total

    def initialize(details)
      @status = details.fetch('status')
      @status_changed = Date.parse(details.fetch('statusChanged'))
      @declined_reason = details.fetch('declinedReason')
      @currency = details.fetch('currency')
      @total = details.fetch('total').to_f
    end
  end
end
