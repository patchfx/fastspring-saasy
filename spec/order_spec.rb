require File.expand_path(File.join(File.dirname(__FILE__), '../lib/fastspring-saasy.rb'))
require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper.rb'))

describe FastSpring::Order do
  before do
    FastSpring::Account.setup do |config|
      config[:username] = 'admin'
      config[:password] = 'test'
      config[:company] = 'acme'
    end
  end

  context 'url for orders' do
    subject { FastSpring::Order.find('test_ref') }
    before do
      stub_request(:get, "https://admin:test@api.fastspring.com/company/acme/order/test_ref").
        to_return(:status => 200, :body => "", :headers => {})
    end

    it 'returns the path for the company and reference' do
      subject.base_order_path.should == "/company/acme/order/test_ref"
    end
  end

  context 'order details' do
    subject { FastSpring::Order.find('test_ref') }
    let(:customer) { mock(:customer) }

    before do
      stub_request(:get, "https://admin:test@api.fastspring.com/company/acme/order/test_ref").
        to_return(stub_http_response_with('basic_order.xml'))
      FastSpring::Customer.stub(:new => customer)
    end

    it 'returns the status' do
      subject.status.should == 'completed'
    end

    it 'returns when the status was changed' do
      subject.status_changed.should be_an_instance_of(DateTime)
    end

  end

end