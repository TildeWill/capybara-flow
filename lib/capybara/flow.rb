require 'capybara/flow/empty_recorder'

module Capybara
  module Flow
    VERSION = File.read(File.join(File.dirname(__FILE__), "..", "..", "VERSION")).freeze

    class << self
      attr_writer :configuration
    end

    def self.configuration
      @configuration ||= Configuration.new
    end

    def self.configure
      yield(configuration)
    end

    def self.included(base)
      base.send(:prepend, UserActions)
    end

    def recorder
      @recorder ||= EmptyRecorder.new
    end

    def recorder=(other)
      @recorder = other
    end

    MATCHERS = [
      :have_content
    ]

    USER_ACTIONS = [
      :attach_file,
      :check,
      :uncheck,
      :choose,
      :click_button,
      :click_link,
      :click_link_or_button,
      :click_on,
      # :evaluate_script, #BAD FOR PERCY
      :execute_script,
      :fill_in,
      :go_back,
      :go_forward,
      :select,
      :unselect,
      :visit
    ].freeze

    module UserActions
      USER_ACTIONS.each do |action_method|
        define_method action_method do |*args, &block|
          super(*args, &block)
          self.recorder.add(self)
        end
      end

      MATCHERS.each do |matcher_method|
        define_method matcher_method do |arg|
          self.recorder.add(self)
          super(arg)
        end
      end
    end
  end
end

require 'capybara/flow/gif_animator'
require 'capybara/flow/gif_recorder'
require 'capybara/flow/configuration'
