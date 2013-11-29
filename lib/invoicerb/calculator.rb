# encoding: UTF-8
module Invoicerb
  class Calculator

    def calculate(quantity, price, discount=nil)
      quantity_amount = extract_number(quantity)
      price_amount    = extract_number(price)
      discount_amount = calculate_discount(quantity, price, discount)
      calculate_with_amounts(quantity_amount, price_amount, discount_amount)
    end

    def calculate_discount(quantity, price, discount)
      # return 0 if no discount set
      return 0 if discount.nil? || discount.number.to_i == 0
      quantity_amount = extract_number(quantity)
      price_amount    = extract_number(price)
      discount_amount = extract_number(discount)
      discount_suffix = discount.suffix
      # return % discount as an amount if suffix is a %
      return (quantity_amount * price_amount) * (discount_amount / 100.0) if discount_suffix == '%'
      # else return discount amount
      discount_amount
    end

    def calculate_with_amounts(quantity, price, discount=nil)
      amount = (quantity * price)
      return amount unless discount || discount == 0
      amount - discount
    end

    def sum(values_array)
      values_array.compact.inject(0) do |sum, value|
        amount = (value.respond_to?(:number)) ? value.number : value
        sum + amount.to_f 
      end
    end

    def extract_number(value)
      value.number.to_f
    end

  end
end


