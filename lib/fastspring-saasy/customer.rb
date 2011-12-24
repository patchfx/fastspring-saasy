module FastSpring
  class Customer
    attr_accessor :first_name, :last_name, :company, :email, :phone_number

    def initialize(details)
      @first_name = details.fetch('firstName', '')
      @last_name = details.fetch('lastName', '') 
      @company = details.fetch('company', '') 
      @email = details.fetch('email')
      @phone_number = details.fetch('phoneNumber', '')
    end

  end
end
