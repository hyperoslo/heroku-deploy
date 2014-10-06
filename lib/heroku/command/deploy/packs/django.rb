# Django deploy pack
class Heroku::Command::Deploy::Pack::Django < Heroku::Command::Deploy::Pack

  def deploy!(branch)
    heroku 'maintenance:on'
    run "git push #{remote} #{branch}:master"

    heroku_run 'python manage.py migrate'
    heroku 'ps:restart'

    heroku 'maintenance:off'
  end

end
