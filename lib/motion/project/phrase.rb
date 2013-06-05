unless defined?(Motion::Project::Config)
  raise "This file must be required within a RubyMotion project Rakefile."
end

class PhraseConfig
  attr_accessor :auth_token

  CONFIG_FILE = './app/phrase_config.rb'

  def initialize(config)
    @config = config
  end

  def auth_token=(auth_token)
    @auth_token = auth_token
    create_phrase_config_file
  end

private
  def create_phrase_config_file
    return unless @auth_token

    if config_file_exists? or config_file_content_outdated?
      File.open(CONFIG_FILE, 'w') { |f| f.write(config_file_content) }
    end
    files = @config.files.flatten
    files << CONFIG_FILE unless files.find { |f| File.expand_path(f) == File.expand_path(CONFIG_FILE) }
  end

  def config_file_exists?
    File.exist?(CONFIG_FILE)
  end

  def config_file_content_outdated?
    File.read(CONFIG_FILE) != config_file_content
  end

  def config_file_content
    content = <<EOF
# This file is automatically generated. Do not edit.
PHRASE_AUTH_TOKEN = "#{@auth_token}"
EOF
    content
  end
end

module Motion
  module Project
    class Config
      variable :phrase

      def phrase
        @phrase ||= PhraseConfig.new(self)
      end
    end
  end
end
