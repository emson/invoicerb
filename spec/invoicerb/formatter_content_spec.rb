require 'spec_helper'

module Invoicerb
  describe FormatterContent do

    let(:data_hash)   { {:date=>"2013-11-22", :invoice_id=>"BCC00001", :client=>"Big Client Company", :jobs=>[{:quantity=>{:prefix=>nil, :number=>"1.00", :suffix=>nil}, :desc=>"Build web page", :price=>{:prefix=>"\u00A3", :number=>"100.00", :suffix=>nil}, :discount=>{:prefix=>nil, :number=>"10.00", :suffix=>"%"}, :total=>{:prefix=>nil, :number=>"90.00", :suffix=>nil}}, {:quantity=>{:prefix=>nil, :number=>"1.00", :suffix=>nil}, :desc=>"Set up servers", :price=>{:prefix=>"\u00A3", :number=>"50.00", :suffix=>nil}, :discount=>{:prefix=>"\u00A3", :number=>"0.00", :suffix=>nil}, :total=>{:prefix=>nil, :number=>"50.00", :suffix=>nil}}, {:quantity=>{:prefix=>nil, :number=>"2.00", :suffix=>nil}, :desc=>"Purchase domain name", :price=>{:prefix=>"\u00A3", :number=>"30.00", :suffix=>nil}, :discount=>{:prefix=>"\u00A3", :number=>"0.00", :suffix=>nil}, :total=>{:prefix=>nil, :number=>"60.00", :suffix=>nil}}], :total_without_taxes=>{:prefix=>"\u00A3", :number=>"200.00", :suffix=>nil}, :total_discounts=>{:prefix=>"\u00A3", :number=>"10.00", :suffix=>nil}, :total_vat=>{:prefix=>"\u00A3", :number=>"40.00", :suffix=>nil}, :total=>{:prefix=>"\u00A3", :number=>"240.00", :suffix=>nil}} }

    let(:config_hash) { { 'vat'=>'20', 'currency'=>'GBP' } }
    let(:jobs) { [["1.00", nil, "Build web page", "10.00%", "20%", "\u00A3100.00", "90.00"], ["1.00", nil, "Set up servers", "\u00A30.00", "20%", "\u00A350.00", "50.00"], ["2.00", nil, "Purchase domain name", "\u00A30.00", "20%", "\u00A330.00", "60.00"]] }

    subject { FormatterContent.new(data_hash, config_hash) }

    it "should build a jobs array" do
      subject.jobs.should == jobs
    end

    it "should build an array of job items from a hash" do
      job_hash = {:quantity=>{:prefix=>nil, :number=>"1.00", :suffix=>nil}, :desc=>"Set up servers", :price=>{:prefix=>"\u00A3", :number=>"50.00", :suffix=>nil}, :discount=>{:prefix=>"\u00A3", :number=>"0.00", :suffix=>nil}, :total=>{:prefix=>nil, :number=>"50.00", :suffix=>nil}}
      job = ["1.00", nil, "Set up servers", "\u00A30.00", "20%", "\u00A350.00", "50.00"]
      subject.build_job(job_hash).should == job
    end

    it "should build a VAT string" do
      subject.vat_str.should == '20%'
    end

    context 'FormatterContent#merge_values' do

      it "should merge the values of a hash together" do
        hash = { prefix:'GBP', number:33, suffix:'%' }
        subject.merge_values(hash).should == 'GBP33%'
      end

      it "should return '-' if the hash is nil" do
        subject.merge_values(nil).should == '-'
      end

      it "should ignore nil or blank hash values" do
        hash = { prefix:nil, number:33 }
        subject.merge_values(hash).should == '33'
      end

    end


  end
end
