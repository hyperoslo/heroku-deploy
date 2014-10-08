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
  #
  def index
    branch = shift_argument || 'master'
    validate_arguments!

    Heroku::Auth.check

    unless remotes = git_remotes
      error('No Heroku remotes detected.')
    end

    unless remote = remotes.key(app)
      error("Remote for #{app} was not found.")
    end

    begin
      pack = Pack.detect.new(app, remote, options)
      pack.deploy!(branch)
      display("\e[92mDeployment successful.\e[0m")
    rescue Pack::NotFound
      error("\e[91mNo suitable deploy pack found.\e[0m")
    rescue Pack::AmbiguousApp
      error("\e[91mAmbiguous application, multiple deploy packs apply.\e[0m")
    rescue CommandExecutionFailure
      error("\e[91m\e[5mDeployment aborted.\e[0m")
    end
  end

end
