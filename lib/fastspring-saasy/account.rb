module FastSpring
  DEFAULT_SSL_CA_FILE = File.expand_path(File.dirname(__FILE__) + "/fastspring.crt")

  module Account
    def self.config
      @config ||= {
        :username => 'user',
        :password => 'pass',
        :company => 'your-company',
        :ssl_ca_file => DEFAULT_SSL_CA_FILE
      }
    end

    def self.[]=(key, val)
      config[key] = val
    end

    def self.fetch(key)
      config[key]
    end

    def self.setup
      yield self
      nil
    end

    def [](key)
      config[key]
    end

  end
end
