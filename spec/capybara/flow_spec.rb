require 'spec_helper'

describe Capybara::Flow do
  ExpectedUserActions = [
    :attach_file,
    :check,
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
    :unselect,
    :visit,
  ]
  class Dummy
    ExpectedUserActions.each do |lazy|
      define_method lazy do |*args, &block|
        instance_variable_set("@#{lazy}", true)
      end

      define_method "#{lazy}?" do |*args, &block|
        !!instance_variable_get("@#{lazy}")
      end
    end
  end

  it 'should have a version number' do
    expect(Capybara::Flow::VERSION).to_not be_nil
  end

  context "included into a class" do
    let(:described_class) { Dummy.send(:include, Capybara::Flow) }

    context "the instance" do
      subject { described_class.new }

      it "should have an EmptyRecorder set to recorder" do
        expect(subject.recorder).to be_a(Capybara::Flow::EmptyRecorder)
      end

      it "should be able to set a recorder" do
        expect do
          subject.recorder = :foo
        end.to change { subject.recorder }
      end

      context "should add itself to the recorder" do
        ExpectedUserActions.each do |attribute|
          it "for #{attribute}" do
            expect(subject.recorder).to receive(:add).with(subject)
            subject.send(attribute)
          end

          it "and still call the original #{attribute}" do
            expect do
              subject.send(attribute)
            end.to change { subject.send"#{attribute}?" }
          end
        end
      end
    end
  end
end
