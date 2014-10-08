# Ruby on Rails deploy pack
class Heroku::Command::Deploy::Pack::Rails < Heroku::Command::Deploy::Pack

  class << self

    def applicable?(dir = Dir.pwd)
      File.exist? File.join(dir, 'Gemfile')
    end

  end

  def deploy!(branch)
    maintenance :on
    push branch

    if migrations?
      heroku_run 'rake db:migrate'
      restart
    end

    maintenance :off
  end

  def migrations?
    File.exists? 'db/migrate'
  end

end
