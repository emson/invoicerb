# encoding: UTF-8

# Add requires for other files you add to your project here, so
# you just need to require this one file in your bin file
require 'rubygems'
require "date"
require "yaml"
require "erb"
require "singleton"
require 'mustache'
require 'prawn'

require_relative 'invoicerb/version'
require_relative 'invoicerb/config'
require_relative 'invoicerb/template_handler'
require_relative 'invoicerb/init_command'
require_relative 'invoicerb/new_command'
require_relative 'invoicerb/build_command'
require_relative 'invoicerb/renderer_pdf'
require_relative 'invoicerb/dsl_invoice'
require_relative 'invoicerb/formatter_content'
require_relative 'invoicerb/calculator'
require_relative 'invoicerb/value'

module Invoicerb
  DOT_DIR = '.invoicerb'
end


