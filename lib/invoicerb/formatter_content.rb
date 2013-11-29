module Invoicerb

  class FormatterContent
    def initialize(data_hash, config_hash)
      @data = data_hash
      @config_hash = config_hash
    end

    def data
      @data
    end

    def config_hash
      @config_hash
    end

    def jobs
      rows = []
      jobs = data[:jobs]
      jobs.each do |job|
        rows << build_job(job)
      end
      rows
    end

    def build_job(job)
      quantity = job[:quantity]
      desc_val = job[:desc]
      discount_val    = merge_values(job[:discount])
      price_val       = merge_values(job[:price])
      price_total_val = merge_values(job[:total])

      number_val   = quantity[:number]
      unit_val     = quantity[:suffix]
      [number_val, unit_val, desc_val, discount_val, vat_str, price_val, price_total_val]
    end

    def vat_str
      vat = config_hash['vat']
      vat = 0 if vat.nil?
      "#{vat}%"
    end

    def data_totals
      total_without_taxes = merge_values(data[:total_without_taxes])
      total_discounts     = merge_values(data[:total_discounts])
      total_vat           = merge_values(data[:total_vat])
      total               = merge_values(data[:total])
      [
        [{:content => "<b>Total without taxes</b>" , :colspan => 6, :align => :right, inline_format:true }, total_without_taxes],
        [{:content => "<b>Discounts</b>"           , :colspan => 6, :align => :right, inline_format:true }, total_discounts],
        [{:content => "<b>VAT(#{vat_str})</b>"     , :colspan => 6, :align => :right, inline_format:true }, total_vat],
        [{:content => "<b>Total taxes</b>"         , :colspan => 6, :align => :right, inline_format:true }, total_vat],
        [{:content => "<b>TOTAL</b>"               , :colspan => 6, :align => :right, inline_format:true }, {:content => "<b>#{total}</b>", :inline_format => true} ]
      ]
    end

    def merge_values(hash)
      return '-' unless hash
      "#{hash[:prefix]}#{hash[:number]}#{hash[:suffix]}"
    end

    def description
      desc = data[:description]
      (desc.nil? || desc.empty?) ? '' : desc
    end

    def contact
      client = data[:client]
      [
        [{:content => load_template('address.erb'), inline_format:true },
         {:content => "<b>Client</b>\n#{client}", :align => :right, inline_format:true }]
      ]
    end

    def invoice_details
      date       = data[:date]
      invoice_id = data[:invoice_id]
      [
        [{:content => "<b>Number: </b>#{invoice_id}", inline_format:true },
         {:content => "<b>Date: </b>#{date}", inline_format:true }]
      ]
    end

    def load_template(filename)
      filename = File.join([templates_dir, filename])
      ERB.new(File.read(filename)).result
    end

    def templates_dir
      begin
        templates = Config.instance.default_config_templates
      rescue
        raise "Please create a templates variable in your config.yml"
      end
      raise "The templates directory does not exist. Check that \"#{templates}\" directory has been created." unless File.exists?(templates)
      templates
    end


  end
end
