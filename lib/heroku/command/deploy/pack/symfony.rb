# Symfony deploy pack
class Heroku::Command::Deploy::Pack::Symfony < Heroku::Command::Deploy::Pack

  class << self

    def applicable?(dir = Dir.pwd)
      File.exist? File.join(dir, 'composer.json')
    end

  end

  def deploy!(branch)
    push branch

    maintenance :on
    heroku_run 'app/console doctrine:migrations:migrate --no-interaction'
    restart
    maintenance :off
  end

end
