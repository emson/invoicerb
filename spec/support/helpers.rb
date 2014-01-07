module Support
  module Helpers
    
    def data_hash
      {:date=>"2013-11-22", :invoice_id=>"BCC00001", :client=>"Big Client Company", :jobs=>[{:quantity=>{:prefix=>nil, :number=>"1.00", :suffix=>nil}, :desc=>"Build web page", :price=>{:prefix=>"\u00A3", :number=>"100.00", :suffix=>nil}, :discount=>{:prefix=>nil, :number=>"10.00", :suffix=>"%"}, :total=>{:prefix=>nil, :number=>"90.00", :suffix=>nil}}, {:quantity=>{:prefix=>nil, :number=>"1.00", :suffix=>nil}, :desc=>"Set up servers", :price=>{:prefix=>"\u00A3", :number=>"50.00", :suffix=>nil}, :discount=>{:prefix=>"\u00A3", :number=>"0.00", :suffix=>nil}, :total=>{:prefix=>nil, :number=>"50.00", :suffix=>nil}}, {:quantity=>{:prefix=>nil, :number=>"2.00", :suffix=>nil}, :desc=>"Purchase domain name", :price=>{:prefix=>"\u00A3", :number=>"30.00", :suffix=>nil}, :discount=>{:prefix=>"\u00A3", :number=>"0.00", :suffix=>nil}, :total=>{:prefix=>nil, :number=>"60.00", :suffix=>nil}}], :total_without_taxes=>{:prefix=>"\u00A3", :number=>"200.00", :suffix=>nil}, :total_discounts=>{:prefix=>"\u00A3", :number=>"10.00", :suffix=>nil}, :total_vat=>{:prefix=>"\u00A3", :number=>"40.00", :suffix=>nil}, :total=>{:prefix=>"\u00A3", :number=>"240.00", :suffix=>nil}}
    end

  end
end
