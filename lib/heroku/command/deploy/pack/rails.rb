# Ruby on Rails deploy pack
class Heroku::Command::Deploy::Pack::Rails < Heroku::Command::Deploy::Pack

  def deploy!(branch)
    push branch

    if migrations?
      maintenance :on
      heroku_run 'rake db:migrate'
      restart
      maintenance :off
    end
  end

  def migrations?
    File.exists? 'db/migrate'
  end

end
