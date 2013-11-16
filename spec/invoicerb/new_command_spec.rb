require 'spec_helper'

module Invoicerb
  describe NewCommand do

    subject { NewCommand.new }
    let(:tokens) { { invoice_name:'some_invoice' } }

    it "should create the invoice file" do
      subject.stub(:source).and_return('source_path')
      subject.stub(:target).and_return('target_path')
      subject.template_handler.should_receive(:write_file).with(subject.source, subject.target, anything())
      subject.create_invoice_file(tokens)
    end

  end
end
