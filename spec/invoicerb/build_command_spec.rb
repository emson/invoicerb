require 'spec_helper'

module Invoicerb
  describe BuildCommand do

    subject { BuildCommand.new }
    let(:tokens) { { invoice_name:'some_invoice', output_name:'some_invoice.pdf' } }

    it "should build an invoice PDF" do
      dsl_invoice_double = double("DslInvoiceDouble", { dsl_load:"dsl_load method called", to_hash:"" } )
      render_double = double("RenderDouble", { build:"build method called" } )
      subject.stub(:source).with(tokens).and_return('source_path')
      subject.stub(:target).with(tokens).and_return('target_path')
      subject.stub(:dsl_invoice).and_return(dsl_invoice_double)
      subject.should_receive(:renderer_pdf).with(any_args()).and_return(render_double)
      subject.build_invoice(tokens)
    end

    context 'BuildCommand#output_name' do

      it "should create an output name based on the invoice name if none provided" do
        tokens = { invoice_name:'chicken_invoice' }
        subject.output_name(tokens).should == 'chicken_invoice.pdf'
      end

      it "should create an output name based on token parameter" do
        tokens = { invoice_name:'chicken_invoice', output_name:'sausage_invoice' }
        subject.output_name(tokens).should == 'sausage_invoice.pdf'
      end

      it "should create an output name based on token parameter with extension" do
        tokens = { invoice_name:'chicken_invoice', output_name:'sausage_invoice.pdf' }
        subject.output_name(tokens).should == 'sausage_invoice.pdf'
      end

      it "should create an output name based on token with extension parameter" do
        tokens = { invoice_name:'chicken_invoice.rb', output_name:'sausage_invoice' }
        subject.output_name(tokens).should == 'sausage_invoice.pdf'
      end

    end

  end
end
