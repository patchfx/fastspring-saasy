require File.expand_path(File.join(File.dirname(__FILE__), '../lib/fastspring-saasy.rb'))
require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper.rb'))

describe FastSpring::Subscription do

  before do
    FastSpring::Account.setup do |config|
      config[:username] = 'admin'
      config[:password] = 'test'
      config[:company] = 'acme'
    end
  end

  context 'url for subscriptions' do
    subject { FastSpring::Subscription.find('test_ref') }
    before do
      stub_request(:get, "https://admin:test@api.fastspring.com/company/acme/subscription/test_ref").
        to_return(:status => 200, :body => "", :headers => {})
    end

    it 'returns the path for the company and reference' do
      subject.base_subscription_path.should == "/company/acme/subscription/test_ref"
    end
  end

  context 'subscription details' do
    subject { FastSpring::Subscription.find('test_ref') }
    let(:customer) { mock(:customer) }
    before do
      stub_request(:get, "https://admin:test@api.fastspring.com/company/acme/subscription/test_ref").
        to_return(stub_http_response_with('basic_subscription.xml'))
      FastSpring::Customer.stub(:new => customer)
    end

    context 'when active' do
      it 'returns the status' do
        subject.status.should == 'active'
      end

      it 'returns the status changed date' do
        subject.status_changed.should be_an_instance_of(DateTime)
      end

      it 'returns the reason for status change' do
        subject.status_reason.should == 'completed'
      end

      it 'is active' do
        subject.should be_active
      end
    end

    it 'returns the cancelable state' do
      subject.should be_cancelable
    end

    it 'returns the referrer' do
      subject.referrer.should == 'acme_app'
    end

    it 'returns the source name' do
      subject.source_name.should == 'acme_source'
    end

    it 'returns the source key' do
      subject.source_key.should == 'acme_source_key'
    end

    it 'returns the source campaign' do
      subject.source_campaign.should == 'acme_source_campaign'
    end

    it 'returns a customer' do
      subject.customer.should == customer
    end

    it 'returns the product name' do
      subject.product_name.should == 'Acme Inc Web'
    end

    it 'returns the next period date' do
      subject.next_period_date.should be_an_instance_of(Date)
    end

    it 'returns the end date' do
      subject.ends_on.should be_an_instance_of(Date)
    end
  end

  context 'renew' do
    subject { FastSpring::Subscription.find('test_ref') }
    before do
      stub_request(:get, "https://admin:test@api.fastspring.com/company/acme/subscription/test_ref").
        to_return(stub_http_response_with('basic_subscription.xml'))
    end

    it 'returns a renewal path' do
      subject.renew_path.should == "/company/acme/subscription/test_ref/renew"
    end
  end
end
