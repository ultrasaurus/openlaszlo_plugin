# using this class is better than checking the enviroment directly,
# since it can later be stubbed for testing

class EnvChecker
  def production?
    ENV['RAILS_ENV'] == 'production'
  end

  def development?
    ENV['RAILS_ENV'] == 'development'
  end
end