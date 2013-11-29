# encoding: UTF-8
module Invoicerb
  class TemplateHandler

    # Read the template directory and recreate it at the specified
    # target path
    def write_file_system(source, target, tokens)
      Dir.glob(File.join(source, '**', '*')).select do |file|
        # strip off the beginning path, specific to tempaltes
        partial_path = path_strip(file, File.join(template_dir, '_name_'))
        # prepend the target path to the template listing
        target_path = File.join([target, partial_path])
        # write files / dirs to file system
        write_file(file, target_path, tokens)
      end
    end

    def write_file(source, target, tokens)
      return unless File.file?(source)
      create_file(target, read_template(source), tokens)
    end


    def replace_token(str, replacement, token='_name_')
      return str unless replacement
      str.gsub(token, replacement)
    end

    # remove the template_dir from the template
    # file path
    def path_strip(path, strip=template_dir)
      path.gsub(strip, '')
    end

    def read_template(file)
      IO.read(file)
    end

    def template_dir
      File.join(File.dirname(__FILE__), 'templates')
    end

    def say(str, prefix='  => ')
      puts "#{prefix}#{str}"
    end

    def apply_template(template, tokens={})
      Mustache.render(template, tokens)
    end

    def create_file(destination, data, tokens)
      unless File.exists? destination
        ::FileUtils.mkdir_p(File.dirname(destination))
        File.open(destination, 'wb') { |f| f.write(apply_template(data, tokens)) }
        say(File.expand_path(destination))
      else
        say(File.expand_path(destination), '  -x ')
      end
    end

  end
end
