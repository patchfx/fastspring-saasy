require File.expand_path(File.join(File.dirname(__FILE__), '../lib/subscription.rb'))
require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper.rb'))

describe FastSpring::Subscription do
  context 'url for subscriptions' do
    subject { FastSpring::Subscription.new('acme', 'test_ref', 'admin', 'test') }
    before do
      stub_request(:get, "https://admin:test@api.fastspring.com/company/acme/subscription/test_ref").
        to_return(:status => 200, :body => "", :headers => {})
    end

    it 'returns the path for the company and reference' do
      subject.base_subscription_path.should == "/company/acme/subscription/test_ref"
    end
  end

  context 'subscription details' do
    subject { FastSpring::Subscription.new('acme', 'test_ref', 'admin', 'test') }
    before do
      stub_request(:get, "https://admin:test@api.fastspring.com/company/acme/subscription/test_ref").
        to_return(stub_http_response_with('basic_subscription.xml'))
    end

    context 'when active' do
      it 'returns the status' do
        subject.status.should == 'active'
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

  end
end
