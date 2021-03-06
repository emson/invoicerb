# encoding: UTF-8
require_relative '../invoicerb' if __FILE__ == $0

module Invoicerb
  class DslInvoice
    include Utils

    def initialize
      # default settings
      @date       = DateTime.now.strftime('%Y-%m-%d')
      @invoice_id = 'INV00001'
      @quote_id   = 'QOT00001'
      @client     = 'No Client Set'
      @client_address = ''
    end

    def prefix
      @prefix ||= config.env_currency
    end

    def tax_rate
      @tax_rate ||= config.env_vat
    end

    def jobs
      @jobs ||= []
    end

    def totals
      @totals ||= []
    end

    def discounts
      @discounts ||= []
    end

    def calculator
      @calculator ||= Calculator.new
    end

    def dsl_load(filename)
      instance_eval(File.read(filename))
    end

    def date(my_date)
      @date = my_date
    end

    def quote_id(my_quote_id)
      @quote_id = my_quote_id
    end

    def invoice_id(my_invoice_id)
      @invoice_id = my_invoice_id
    end

    def client(my_client, &block)
      @client = my_client
      # extract the client child block
      instance_exec(&block)
    end

    def client_address(my_client_address)
      @client_address = my_client_address
    end

    def job(qty, desc, price, discount)
      quantity = Value.new(qty, :quantity)
      price    = Value.new(price)
      discount = Value.new(discount)
      total    = Value.new(build_job_total(quantity, price, discount))
      discounts << discount
      totals    << total
      jobs      << { quantity:quantity.to_hash,
                     desc:desc,
                     price:price.to_hash,
                     discount:discount.to_hash,
                     total:total.to_hash }
    end

    def build_job_total(quantity, price, discount)
      total = calculator.calculate(quantity, price, discount)
      build_str(price.raw_prefix, total)
    end

    def build_str(prefix, number, suffix=nil)
      "#{prefix}#{number}#{suffix}"
    end

    def total_without_taxes
      @total_without_taxes ||= calculator.sum(totals)
    end

    def total_discounts
      @total_discounts ||= calculator.sum(discounts)
    end

    def total_vat
      @total_vat ||= vat(total_without_taxes)
    end

    def total
      @total ||= (total_without_taxes) + total_vat
    end

    def vat(price)
      price * (tax_rate / 100.00)
    end

    def to_hash
      # TODO refactor totals into a totals sub array
      {
        date: @date,
        invoice_id: @invoice_id,
        client: @client,
        client_address: @client_address,
        jobs: jobs,
        totals: {
          total_without_taxes: Value.new(build_str(prefix, total_without_taxes)).to_hash,
          total_discounts:     Value.new(build_str(prefix, total_discounts)).to_hash,
          total_vat:           Value.new(build_str(prefix, total_vat)).to_hash,
          total:               Value.new(build_str(prefix, total)).to_hash,
        }
      }
    end

  end
end

if __FILE__ == $0
  # puts ARGV[0]
  # filepath = File.join([ File.dirname(__FILE__), 'example_invoice.rb' ])
  filepath = File.join([  'example_invoice.rb' ])
  app = Invoicerb::DslInvoice.new
  app.dsl_load(filepath)
  puts
  puts app.to_hash
  puts
end
