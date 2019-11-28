require 'spec_helper'
require 'securerandom'

require 'capybara/flow/gif_recorder'

describe Capybara::Flow::GifRecorder, type: :recorder do
  let(:gif_animator) { instance_double(Capybara::Flow::GifAnimator, add: true, frames: [], generate!: true) }
  let(:tmpdir) { FileUtils.mkdir_p(Dir.pwd+"/tmp").first }
  let(:output_name) { "the file name" }
  let(:recorder) { described_class.new(output_name) }

  before do
    allow(Capybara::Flow::GifAnimator).to receive(:new).and_return(gif_animator)
    allow(Dir).to receive(:mktmpdir).and_return(tmpdir)
  end

  subject { recorder }

  it "should create the output path if it does not yet exist" do
    unique_path = Dir.pwd+"/tmp/#{SecureRandom::uuid}/foobar"
    expect do
      described_class.new(unique_path)
    end.to change { File.exists?(File.dirname(unique_path))}
  end

  it "sets the output_file based on initialization values" do
    expect(subject.output_file).to eql("#{output_name}.gif")
  end

  describe "#add" do
    let(:page) { double(save_screenshot: true) }

    let(:adding) { proc { recorder.add(page) } }
    subject { adding.call }

    it "should save a screenshot from the page to a file in the output directory so you can go frame by frame" do
      expect(page).to receive(:save_screenshot).with("the file name/0.png", hash_including(:width, :height))
      subject
    end

    it "should add the saved frame to the animation" do
      expect(gif_animator).to receive(:add).with("the file name/0.png")
      subject
    end
  end

  describe "#generate!" do
    let(:generating) { proc { recorder.generate! } }
    subject { generating.call }

    it "should generate the animation" do
      expect(gif_animator).to receive(:generate!)
      subject
    end
  end
end
