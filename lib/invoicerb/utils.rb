# encoding: UTF-8
module Invoicerb
  module Utils

    def config
      @config ||= Config.instance
    end

  end
end
