# Ruby on Rails deploy pack
class Heroku::Command::Deploy::Pack::Rails < Heroku::Command::Deploy::Pack

  def deploy!(branch)
    heroku 'maintenance:on'
    run "git push #{remote} #{branch}:master"

    if migrations?
      heroku_run 'rake db:migrate'
      heroku 'ps:restart'
    end

    heroku 'maintenance:off'
  end

  def migrations?
    File.exists? 'db/migrate'
  end

end
