module Capybara
  module Flow
    class GifRecorder
      attr_reader :output_file

      def initialize(output_name)
        @frame_dir = output_name
        @output_file = "#{output_name}.gif"
        make_path_unless_exists(output_file)
        make_path_unless_exists(@frame_dir)
        @gif_animator = GifAnimator.new(output_file, delay_in_ms: Capybara::Flow.configuration.delay_in_ms, iterations: Capybara::Flow.configuration.iterations)
        @tmpdir = Dir.mktmpdir
      end

      def add(page)
        file = File.join(@frame_dir, "#{current_frame}.png")
        page.save_screenshot(file, width: 320, height: 480)
        gif_animator.add(file)
      end

      def generate!
        gif_animator.generate!
      end

      private
      attr_reader :tmpdir, :gif_animator

      def current_frame
        gif_animator.frames.length
      end

      def make_path_unless_exists(file)
        FileUtils.mkdir_p(File.dirname(file)) unless File.exists?(File.dirname(file))
      end
    end
  end
end
