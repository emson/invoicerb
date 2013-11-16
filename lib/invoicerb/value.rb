# encoding: UTF-8
module Invoicerb
  class Value
    attr_reader :prefix, :number, :suffix, :tokens

    def initialize(hash)
      @tokens = extract_from(hash)
    end

    def to_hash
      @tokens
    end

    def format_prefix(prefix)
      return unless prefix
      prefix = 'EUR' if prefix.upcase == 'EURO'
      symbols = { gbp:"\u00A3", usd:"\u0024", eur:"\u20AC", yen:"\u00A5" }
      symbols[prefix.downcase.to_sym]
    end

    def format_number(number)
      return unless number
      sprintf("%.2f", number)
    end

    def format_suffix(suffix)
      return unless suffix
      suffix.downcase
    end

    private

    def extract_from(str)
      # extract from GBP456.23% to be
      # { prefix:GBP, number:456.23, suffix:% }
      regx = /([a-zA-Z]*)(\d+[\.]*\d*)([a-zA-Z%]*)/.match(str)
      @prefix   = format_prefix((regx[1].empty?) ? nil : regx[1])
      @number   = format_number((regx[2].empty?) ? nil : regx[2])
      @suffix   = format_suffix((regx[3].empty?) ? nil : regx[3])
      { prefix:@prefix, number:@number, suffix:@suffix }
    end

  end
end


