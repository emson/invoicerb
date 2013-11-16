require 'spec_helper'

module Invoicerb
  describe TemplateHandler do

    subject { TemplateHandler.new }

    it "should write a template file to the filesystem" do
      tokens = {}
      source_path = File.join(subject.template_dir, 'invoice', '_name_.rb')
      target_path = File.join(Dir.home, 'my_file')
      File.stub(:open).with(target_path, 'wb').and_return(target_path)
      subject.should_receive(:say).with(target_path)
      subject.write_file(source_path, target_path, tokens)
    end


  end
end
