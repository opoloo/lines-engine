# use config file from host app as default
config_file = Rails.root.join('config', 'lines_config.yml')

# use engine's config file if not exists in host app
unless File.exists?(config_file)
  config_file = Lines::Engine.root.join('config', 'lines_config.yml')
end

# Load the configuration
#CONFIG = YAML.load_file(config_file)
CONFIG = YAML.load(ERB.new(File.read(config_file)).result)
CONFIG.merge! CONFIG.fetch(Rails.env, {})
CONFIG.symbolize_keys!
