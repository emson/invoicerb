require 'spec_helper'

module Invoicerb
  describe BuildCommand do

    subject { BuildCommand.new }
    let(:tokens) { { invoice_name:'some_invoice', output_name:'some_invoice.pdf' } }

    it "should build an invoice PDF" do
      pending
      subject.stub(:source).with(tokens).and_return('source_path')
      subject.stub(:target).with(tokens).and_return('target_path')
      subject.build_invoice(tokens)
    end

  end
end
