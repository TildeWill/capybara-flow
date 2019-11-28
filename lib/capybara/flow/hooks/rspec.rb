if defined?(Capybara::Session)
  Capybara::Session.send(:include, Capybara::Flow)
  RSpec.configure do |config|
    config.before(:each, :js) do |example|
      output_path = File.join(Capybara::Flow.configuration.save_path, example.full_description.parameterize)
      page.recorder = Capybara::Flow::GifRecorder.new(output_path)
    end

    config.after(:each, :js) do
      page.recorder.add(page)
      page.recorder.generate!
    end
  end
end
