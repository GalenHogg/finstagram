configure do
  # Log queries to STDOUT in development
if Sinatra::Application.development?
  set :database, {
  adapter: "sqlite3",
  database: "db/db.sqlite3"
  }
else
  db = URI.parse(ENV['DATABASE_URL'] || 'postgres://lvurjakmbikpji:cefc196c033a48c0a8d8ca7ed52e1d41e0e635fc4ee6ebb2243d4ce72e5e243d@ec2-54-83-27-165.compute-1.amazonaws.com:5432/de367h28uoddid')
  set :database, {
  adapter: "postgresql",
  host: db.host,
  username: db.user,
  password: db.password,
  database: db.path[1..-1],
  encoding: "utf8"
  }

end

  # Load all models from app/models, using autoload instead of require
  # See http://www.rubyinside.com/ruby-techniques-revealed-autoload-1652.html
  Dir[APP_ROOT.join('app', 'models', '*.rb')].each do |model_file|
    filename = File.basename(model_file).gsub('.rb', '')
    autoload ActiveSupport::Inflector.camelize(filename), model_file
  end

end
