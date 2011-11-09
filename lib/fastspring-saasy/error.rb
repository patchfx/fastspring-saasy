module FastSpring
  module Error

    class NotFound < StandardError
      attr_reader :response

      def initialize(response=nil)
        @response  = response
      end
    end

  end
end
