module FastSpring
  module Account

    def self.config
      @config ||= {:username => 'user', :password => 'pass', :company => 'your-company'}
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
