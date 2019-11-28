require "RMagick"

module Capybara
  module Flow
    class GifAnimator
      attr_reader :frames, :delay, :iterations, :output_file

      def initialize(output_file, options = {})
        @delay = options[:delay_in_ms]
        @iterations = options[:iterations]
        @output_file = output_file
        @frames = []
      end

      def add(frame)
        frames << frame
      end

      def generate!
        gif = ::Magick::ImageList.new(*frames)
        gif.delay = delay if delay
        gif.iterations = iterations if iterations
        gif.ticks_per_second = 1000
        gif.write(output_file)
      end
    end
  end
end
