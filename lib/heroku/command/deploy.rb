require 'heroku/command/base'

# deploys applications
class Heroku::Command::Deploy < Heroku::Command::Base

  # Raised when a command failed to abort deployment
  class CommandExecutionFailure < StandardError; end

  # deploy [BRANCH]
  #
  #   Deploys given branch (default 'master') to given app or remote
  #
  #   -a, --app    APP     # the app to deploy to
  #   -r, --remote REMOTE  # the git remote to deploy to, default 'heroku'
  #   --dry-run            # dry-runs deployment
  #   --force              # forces code deployment
  #
  def index
    branch = shift_argument || 'master'
    validate_arguments!

    Heroku::Auth.check

    unless remotes = git_remotes
      error('No Heroku remotes detected.'.red)
    end

    unless remote = remotes.key(app)
      error("Remote for #{app} was not found.".red)
    end

    begin
      pack = Pack.detect.new(app, remote, options)
      pack.deploy!(branch)
      display('Deployment successful.'.green)
    rescue Pack::NotFound
      error('No suitable deploy pack found.'.red)
    rescue Pack::AmbiguousApp
      error('Ambiguous application, multiple deploy packs apply.'.red)
    rescue CommandExecutionFailure
      error('Deployment aborted.'.red.blink)
    end
  end

end
