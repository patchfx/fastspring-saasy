require File.expand_path(File.join(File.dirname(__FILE__), '../lib/fastspring-saasy.rb'))
require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper.rb'))

describe FastSpring::Account do
  before do
    FastSpring::Account.setup do |config|
      config[:username] = 'johndoe'
      config[:password] = 'secret'
      config[:company] = 'acme'
    end
  end
  it 'stores the configuration for the account setup' do
    FastSpring::Account.config.should == {
      :username=>"johndoe",
      :password=>"secret",
      :company=>"acme",
      :ssl_ca_file=>"#{Dir.pwd}/lib/fastspring-saasy/fastspring.crt"
    }
  end
end
