# encoding: UTF-8
module Invoicerb
  class Config
    include Singleton

    PREFIX = 'env_'

    def environment
      shell_env["RAILS_ENV"] || shell_env["RACK_ENV"] || shell_env["ENV"] || 'development'
    end

    def shell_env
      @shell_env ||= ENV
    end

    def default_config
      File.join([default_config_dir, 'invoicerb'])
    end

    def default_config_templates
      File.join([default_config_dir, 'templates'])
    end

    def default_config_dir
      File.join([Dir.home, DOT_DIR])
    end

    def config(path=nil)
      path = default_config unless path
      yaml = YAML.load(ERB.new(File.new(path).read).result)
      raise "Your HOME/.invoicerb file is not configured correctly" if yaml.nil? || yaml == false
      yaml
    end


    def method_missing(method_name, *arguments, &block)
      if method_name.to_s =~ /^#{PREFIX}(.*)/
        key = method_name.to_s.gsub(PREFIX, '')
        environment_variable(key)
      else
        super
      end
    end


    def respond_to_missing?(method_name, include_private=false)
      method_name.to_s.start_with?(PREFIX) || super
    end


    def environment_variable(key)
      case
      when key.nil? || key.empty?
        raise(StandardError, "No environment variable was specified e.g. config.env_saussage")
      when sys_var = system_environment_variable(key)
        return sys_var
      when config_var = config_variable(key)
        return config_var
      else
        raise(StandardError,
              "#{key.upcase} is not a shell variable and '#{key}' is not a YAML config key!")
      end
    end


    def system_environment_variable(key)
      return unless key
      # get the environment variable from OS
      shell_env[key.upcase]
    end


    def config_variable(key)
      # it from config file
      config[key]
    end

  end
end
