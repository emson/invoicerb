# encoding: UTF-8
module Invoicerb
  class Calculator

    def calculate(quantity, price, discount=nil)
      amount = (quantity.number.to_f * price.number.to_f)
      return amount unless discount
      amount - discount.number.to_f
    end

    def sum(array)
      array.inject(0) { |sum, value| sum + value.number.to_f }
    end


  end
end


