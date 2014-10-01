module Lines
  if defined?(Rails)
    require "lines/engine"
  end

  # host application root path
  # We set this when the engine is initialized
  mattr_accessor :app_root

  # Yield self on setup for nice config blocks
  def self.setup
    yield self
  end
end
