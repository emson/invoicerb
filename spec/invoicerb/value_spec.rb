require 'spec_helper'

module Invoicerb
  describe Value do

    let(:str)    { "GBP123%" }
    let(:hash)   { {:prefix=>"\u00A3", :number=>"123.00", :suffix=>"%"} }

    subject { Value.new(str) }

    it "should return the raw prefix" do
      subject.raw_prefix.should == "GBP"
    end

    it "should return the prefix" do
      subject.prefix.should == "\u00A3"
    end

    it "should return the number" do
      subject.number.should == "123.00"
    end

    it "should return the suffix" do
      subject.suffix.should == "%"
    end

    it "should parse a string of values and create a hash" do
      subject.to_hash.should == hash
    end

    it "should handle blank suffix" do
      value = Value.new("GBP123")
      value.prefix.should == "\u00A3"
      value.number.should == "123.00"
      value.suffix.should == nil
    end

    it "should handle blank prefix" do
      value = Value.new("123")
      value.prefix.should == nil
      value.number.should == "123.00"
      value.suffix.should == nil
    end

    it "should create the correct currency symbol" do
      subject.format_prefix("GBP").should  == "\u00A3"
      subject.format_prefix("USD").should  == "\u0024"
      subject.format_prefix("EUR").should  == "\u20AC"
      subject.format_prefix("EURO").should == "\u20AC"
      subject.format_prefix("YEN").should  == "\u00A5"
    end

    it "should handle a blank string" do
      value = Value.new('')
      value.prefix.should == nil
      value.number.should == nil
      value.suffix.should == nil
    end

    it "should handle a nil initializer" do
      value = Value.new(nil)
      value.prefix.should == nil
      value.number.should == nil
      value.suffix.should == nil
    end

    it "should display as number rounding" do
      value = Value.new("GBP345", :number)
      value.number.should == "345"
    end

    it "should display as currency rounding" do
      value = Value.new("GBP345", :currency)
      value.number.should == "345.00"
    end

    it "should default to currency rounding" do
      value = Value.new("GBP345")
      value.number.should == "345.00"
    end

  end
end
