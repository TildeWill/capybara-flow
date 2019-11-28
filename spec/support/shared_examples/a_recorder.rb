shared_examples_for type: :recorder do
  it { should respond_to(:add) }

  it { should respond_to(:generate!) }

  describe "#add" do
    it "should accept an argument" do
      expect do
        subject.add(double(save_screenshot: true))
      end.to_not raise_error
    end
  end
end
