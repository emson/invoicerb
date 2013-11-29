# encoding: UTF-8
module Invoicerb
  class NewCommand

    def create_invoice_file(tokens)
      template_handler.write_file(source, target(tokens), apply_defaults(tokens))
    end

    def source
      invoice_template_dir = File.join( template_handler.template_dir, 'invoice' )
      File.join(invoice_template_dir, 'invoice_template.rb.mustache')
    end

    def target(tokens)
      target_file = tokens[:invoice_name]
      target_file = "#{target_file}.rb" if File.extname(target_file).empty?
      File.join(target_file)
    end

    def apply_defaults(tokens)
      { date: DateTime.now.strftime('%Y-%m-%d') }.merge(tokens)
    end

    def template_handler
      @template_handler ||= TemplateHandler.new
    end

  end
end
