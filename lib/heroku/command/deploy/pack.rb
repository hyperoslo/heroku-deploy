# Denotes a deploy pack handling deployment for a language or framework
class Heroku::Command::Deploy::Pack

  include Heroku::Command::Deploy::Helpers

  # Raised when a pack could not be found
  class NotFound < StandardError; end

  # Raised when more than one pack applies
  class AmbiguousApp < StandardError; end

  attr_reader :app, :remote

  class << self

    # Registers given pack automatically when extending base pack
    def inherited(pack)
      (@registry ||= []) << pack
    end

    # Attempts to detect deploy pack to use for app in given directory
    def detect(dir = Dir.pwd)
      candidates = @registry.find_all do |pack|
        pack.applicable? dir
      end

      raise NotFound if candidates.empty?
      raise AmbiguousApp if candidates.length > 1

      candidates.first
    end

    # Whether this pack applies for the given directory
    def applicable?(dir = Dir.pwd)
      false
    end

  end

  # Initializes deploy pack
  def initialize(app, remote, options)
    @app = app
    @remote = remote
    @options = options
  end

  # Deploys given branch
  def deploy!(branch)
    raise NotImplementedError
  end

end
