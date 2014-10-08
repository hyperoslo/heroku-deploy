# Django deploy pack
class Heroku::Command::Deploy::Pack::Django < Heroku::Command::Deploy::Pack

  class << self

    def applicable?(dir = Dir.pwd)
      File.exist? File.join(dir, 'requirements.txt')
    end

  end

  def deploy!(branch)
    maintenance :on
    push branch

    heroku_run 'python manage.py migrate'
    restart

    maintenance :off
  end

end
