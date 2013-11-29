# encoding: UTF-8
module Invoicerb
  class Value
    attr_reader :raw_prefix, :prefix, :number, :suffix, :tokens, :rounding

    def initialize(hash, rounding=:currency)
      @rounding = rounding
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
      return sprintf("%.2f", number) if rounding == :currency
      sprintf("%g", number)
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
      @raw_prefix   = (regx[1].empty?) ? nil : regx[1]
      @prefix       = format_prefix(@raw_prefix)
      @number       = format_number((regx[2].empty?) ? nil : regx[2])
      @suffix       = format_suffix((regx[3].empty?) ? nil : regx[3])
      { prefix:@prefix, number:@number, suffix:@suffix }
    end

  end
end


