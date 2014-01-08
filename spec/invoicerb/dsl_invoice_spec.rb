require 'spec_helper'

module Invoicerb
  describe DslInvoice do

    subject { DslInvoice.new }

    before(:each) do
      double_config = double('DoubleConfig', { env_currency:'GBP', env_vat:20.0 })
      subject.stub(:config).and_return(double_config)
    end

    it "should set the prefix to the config currency" do
      subject.prefix.should == 'GBP'
    end

    it "should set the tax_rate to the config currency" do
      subject.tax_rate.should == 20.0
    end

    it "should calculate the tax rate" do
      subject.vat(200).should == 40.0
    end

    it "should create a hash" do
      subject.date('2011-11-11')
      subject.to_hash.should == { :date=>"2011-11-11",
                                  :invoice_id=>"INV00001",
                                  :client=>"No Client Set",
                                  :jobs=>[],
                                  :totals=>{
                                    :total_without_taxes=>{
                                      :prefix=>"£",
                                      :number=>"0.00",
                                      :suffix=>nil},
                                    :total_discounts=>{
                                      :prefix=>"£",
                                      :number=>"0.00",
                                      :suffix=>nil},
                                    :total_vat=>{
                                      :prefix=>"£",
                                      :number=>"0.00",
                                      :suffix=>nil},
                                    :total=>{
                                      :prefix=>"£",
                                      :number=>"0.00",
                                      :suffix=>nil}}}
    end

  end
end

