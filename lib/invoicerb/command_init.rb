# encoding: UTF-8
module Invoicerb
  class CommandInit

    def generate_dot_dir
      template_handler.write_file_system(source, target, {})
    end

    def source
      system_template_dir = File.join( template_handler.template_dir, '_name_' )
      File.expand_path(system_template_dir)
    end

    def target
      File.join(Dir.home, DOT_DIR)
    end

    def template_handler
      @template_handler ||= TemplateHandler.new
    end

  end
end
