# encoding: UTF-8
module Invoicerb
  class BuildCommand

    def build_invoice(tokens)
      # puts config.env_vat
      # puts template_handler.read_template(File.join(config.default_config_dir, 'templates', 'company.erb'))
      dsl_invoice.dsl_load(invoice_name(tokens))
      invoice_hash = dsl_invoice.to_hash
      config_hash  = config.config
      output       = 'output.pdf'
      formatter    = FormatterContent.new(invoice_hash)
      renderer_pdf.build(formatter, config_hash, output)
    end

    def invoice_name(tokens)
      invoice_name = tokens[:invoice_name]
      invoice_name = "#{invoice_name}.rb" if File.extname(invoice_name).empty?
      invoice_name
    end

    def dsl_invoice
      @dsl_invoice ||= DslInvoice.new
    end

    def renderer_pdf
      @renderer_pdf ||= RendererPdf.new
    end

    def config
      @config ||= Config.instance
    end

    def source(tokens)
      source_file = tokens[:invoice_name]
      "#{source_file}.rb" if File.extname(source_file).empty?
    end

    def target(tokens)
      target_file = tokens[:output_name]
      target_file = "#{target_file}.pdf" if File.extname(target_file).empty?
      File.join(target_file)
    end

    def renderer
      @renderer ||= RendererPdf.new
    end

    def template_handler
      @template_handler ||= TemplateHandler.new
    end

  end
end
