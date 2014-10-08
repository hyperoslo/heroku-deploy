# Django deploy pack
class Heroku::Command::Deploy::Pack::Django < Heroku::Command::Deploy::Pack

  def deploy!(branch)
    push branch

    maintenance :on
    heroku_run 'python manage.py migrate'
    restart
    maintenance :off
  end

end
