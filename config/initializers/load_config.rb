CONFIG = YAML.load(File.read(File.expand_path('../../lines_config.yml', __FILE__)))
CONFIG.merge! CONFIG.fetch(Rails.env, {})
CONFIG.symbolize_keys!