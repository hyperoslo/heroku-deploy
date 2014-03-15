# Denotes a deploy pack handling deployment for a language or framework
class Heroku::Command::Deploy::Pack

  include Heroku::Command::Deploy::Helpers

  attr_reader :app, :remote

  # Attempts to detect deploy pack to use for app in given directory
  def self.detect(dir = Dir.pwd)
    # TODO: Defaulting to Rails for now, awaiting implementation
    Rails
  end

  # Initializes deploy pack
  def initialize(app, remote)
    @app = app
    @remote = remote
  end

end
