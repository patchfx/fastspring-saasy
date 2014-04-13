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

  context 'search' do
    it 'searches for orders from a given query' do
      stub_request(:get, "https://admin:test@api.fastspring.com/company/acme/orders/search?query=doe").
        to_return(stub_http_response_with('basic_order_search.xml'))

      orders = FastSpring::Order.search('doe')
      orders.size.should be(2)
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
    let(:address) { mock(:address) }
    let(:item) { mock(:item) }
    let(:payment) { mock(:payment) }

    before do
      stub_request(:get, "https://admin:test@api.fastspring.com/company/acme/order/test_ref").
        to_return(stub_http_response_with('basic_order.xml'))
      FastSpring::Customer.stub(:new => customer)
      FastSpring::Address.stub(:new => address)
      FastSpring::Item.stub(:new => item)
      FastSpring::Payment.stub(:new => payment)
    end

    it 'returns the status' do
      subject.status.should == 'completed'
    end

    it 'returns when the status was changed' do
      subject.status_changed.should be_an_instance_of(DateTime)
    end

    it 'returns the order reference' do
      subject.reference.should == 'TEST-0RD3R'
    end

    it 'returns the test status' do
      subject.test?.should be_false
    end

    it 'returns the due date' do
      subject.due.should be_an_instance_of(DateTime)
    end

    it 'returns the currency code' do
      subject.currency.should == 'GBP'
    end

    it 'returns the referrer' do
      subject.referrer.should == 'acme_web'
    end

    it 'returns the origin ip' do
      subject.origin_ip.should == '123.456.789.0'
    end

    it 'returns the purchaser' do
      subject.purchaser.should == customer
    end

    it 'returns the total' do
      subject.total.should == 10.00
    end

    it 'returns the tax' do
      subject.tax.should == 1.00
    end

    it 'returns the shipping' do
      subject.shipping.should == 0.0
    end

    it 'returns the address' do
      subject.address.should == address
    end

    context 'items' do
      it 'has an order item' do
        subject.items.should == [item]
      end
    end

    it 'has a payment' do
      subject.payment.should == payment
    end

  end

end
