require 'spec_helper'

module Invoicerb
  describe CommandInit do

    subject { CommandInit.new }

    it "should create a .invoicerb dir in the HOME directory" do
      subject.stub(:source).and_return('source_path')
      subject.stub(:target).and_return('target_path')
      subject.template_handler.should_receive(:write_file_system).with(subject.source, subject.target, {})
      subject.generate_dot_dir
    end

  end
end
