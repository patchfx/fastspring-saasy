require File.expand_path(File.join(File.dirname(__FILE__), '../lib/fastspring-saasy.rb'))
require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper.rb'))

describe FastSpring::LocalizedStorePricing do

  before do
    FastSpring::Account.setup do |config|
      config[:username] = 'admin'
      config[:password] = 'test'
      config[:company] = 'acme'
    end
  end

  context 'url for localized store pricing' do
    subject { FastSpring::LocalizedStorePricing.find('/standard', "1.2.3.4") }
    before do
      stub_request(:get, "http://api.fastspring.com/bizplay/api/price?product_1_path=/standard&user_accept_language=&user_remote_addr=1.2.3.4&http_accept_language=en").
        to_return(:status => 200, :body => "", :headers => {})
    end
  
    it 'returns the path for the company' do
      subject.base_localized_store_pricing_path.should == "/acme/api/price"
    end
  end
  
  context "parsed response" do
    subject { FastSpring::LocalizedStorePricing.find('/standard', "1.2.3.4") }
    before do
      stub_request(:get, "http://api.fastspring.com/bizplay/api/price?product_1_path=/standard&user_accept_language=&user_remote_addr=1.2.3.4&http_accept_language=en").
        to_return(stub_http_response_with('basic_localized_store_pricing.txt'))
    end

    it 'returns "US" as the user country' do
      subject.user_country.should == "US"
    end

    it 'returns "en" as the user language' do
      subject.user_language.should == "en"
    end
    
    it 'returns "USD" as the user currency' do
      subject.user_currency.should == "USD"
    end
    
    it 'returns "/standard" as the path of product 1' do
      subject.product_path(1).should == "/standard"
    end
    
    it 'returns "1" as the quantity of product 1' do
      subject.product_quantity(1).should == "1"
    end
    
    it 'returns "35.00" as unit value of product 1' do
      subject.product_unit_value(1).should == "35.00"
    end
    
    it 'returns "USD" as the unit currency of product 1' do
      subject.product_unit_currency(1).should == "USD"
    end
    
    it 'returns "$35.00" as the unit display of product 1' do
      subject.product_unit_display(1).should == "$35.00"
    end
    
    it 'returns "$35.00" as the unit html of product 1' do
      subject.product_unit_html(1).should == "$35.00"
    end
  end
end
