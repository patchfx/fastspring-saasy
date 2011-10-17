require File.expand_path(File.join(File.dirname(__FILE__), '../lib/subscription.rb'))

describe FastSpring::Subscription do
  context 'new' do
    it 'has a company id' do
      FastSpring::Subscription.new('acme').company_id.should == 'acme'
    end
  end
end
