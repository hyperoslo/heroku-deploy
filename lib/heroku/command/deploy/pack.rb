# Denotes a deploy pack handling deployment for a language or framework
class Heroku::Command::Deploy::Pack

  include Heroku::Command::Deploy::Helpers

  attr_reader :app, :remote

  # Attempts to detect deploy pack to use for app in given directory
  def self.detect(dir = Dir.pwd)
    # TODO: Improve on the detection implementation. Now we default
    # to Rails for Ruby projects, and Django for Python projects.

    if File.exist?(File.join(dir, 'Gemfile'))
      # Presence of a `Gemfile` indicates a Ruby application
      Rails
    elsif File.exist?(File.join(dir, 'requirements.txt'))
      # Presence of a `requirements.txt` file indicates a Python application.
      Django
    end
  end

  # Initializes deploy pack
  def initialize(app, remote)
    @app = app
    @remote = remote
  end

  # Deploys given branch
  def deploy!(branch)
    raise NotImplementedError
  end

end
