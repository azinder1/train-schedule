require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/train')
require('./lib/city')
require('pg')
require('pry')

DB = PG.connect({:dbname => "trains_schedule"})

get('/') do
  erb(:index)
end

get('/routes') do
  @cities = City.all
  @trains = Train.all
  @schedule = Train.all_routes
  erb(:routes)
end

post('/routes/new') do
  date =  params['date']
  train = Train.find(params['trains'].to_i)
  city_id = params['cities'].to_i
  train.update({:city_ids => [city_id], :times => [date]})
  @schedule = Train.all_routes
  erb(:routes)
end


get('/city/new') do
  erb(:new_city)
end
