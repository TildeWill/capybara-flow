module Capybara
  module Flow
    class Configuration
      attr_accessor :delay_in_ms
      attr_accessor :iterations
      attr_accessor :save_path

      def initialize
        @delay_in_ms = 70
        @iterations = nil
        @save_path = "html-report/"
      end
    end
  end
end
