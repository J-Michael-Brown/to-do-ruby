require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/Contact')
require('pry')

DB = PG.connect({:dbname => "to_do"})

# get ('/') do
#   @contact = ''
#   Address::Contact.clear
#   erb(:input)
# end
#
