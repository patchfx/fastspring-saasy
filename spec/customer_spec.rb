require File.expand_path(File.join(File.dirname(__FILE__), '../lib/fastspring-saasy.rb'))
require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper.rb'))

describe FastSpring::Customer do
  context 'new' do
    let(:customer_details) {
      {
        "firstName" => "John",
        "lastName" => "Doe",
        "company" => "Doe Inc",
        "email" => "john@example.com",
        "phoneNumber" => "0123456789"
      }
    }
    subject { FastSpring::Customer.new(customer_details) }

    it 'has a first name' do
      subject.first_name.should == 'John'
    end

    it 'has a last name' do
      subject.last_name.should == 'Doe'
    end

    it 'has a company' do
      subject.company.should == 'Doe Inc'
    end

    it 'has a email address' do
      subject.email.should == 'john@example.com'
    end

    it 'has a phone number' do
      subject.phone_number.should == '0123456789'
    end
  end
end
