# Ruby on Rails deploy pack
class Heroku::Command::Deploy::Pack::Rails < Heroku::Command::Deploy::Pack

  def deploy!(branch)
    heroku 'maintenance:on'
    run "git push #{remote} #{branch}:master"
    heroku_run 'rake db:migrate'
    heroku 'ps:restart'
    heroku 'maintenance:off'
  end

end
