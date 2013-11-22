# encoding: UTF-8
module Invoicerb
  class BuildCommand
    include Utils

    def build_invoice(tokens)
      binding.pry
      dsl_invoice.dsl_load(invoice_name(tokens))
      invoice_hash = dsl_invoice.to_hash
      config_hash  = config.config
      output       = output_name(tokens)
      formatter    = FormatterContent.new(invoice_hash, config_hash)
      renderer_pdf.build(formatter, config_hash, output)
    end

    def output_name(tokens)
      output = tokens[:output_name]
      return apply_ext(output, '.pdf') unless output.nil? || output.empty?
      invoice_name = invoice_name(tokens)
      invoice_name.gsub(File.extname(invoice_name), '.pdf')
    end

    def invoice_name(tokens)
      apply_ext(tokens[:invoice_name])
    end

    def apply_ext(name, ext='.rb')
      name = "#{name}#{ext}" if File.extname(name).empty?
      name
    end

    def dsl_invoice
      @dsl_invoice ||= DslInvoice.new
    end

    def renderer_pdf
      @renderer_pdf ||= RendererPdf.new
    end

    # def config
    #   @config ||= Config.instance
    # end

    # def template_handler
    #   @template_handler ||= TemplateHandler.new
    # end

  end
end
