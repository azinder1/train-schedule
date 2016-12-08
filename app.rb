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
  date =  params['date'] +" "+params['time']
  train = Train.find(params['trains'].to_i)
  city_id = params['cities'].to_i
  train.update({:city_ids => [city_id], :times => [date]})
  @cities = City.all
  @trains = Train.all
  @schedule = Train.all_routes
  erb(:routes)
end


get('/city') do
  erb(:new_city)
end

get('/routes/routes/city') do
  erb(:new_city)
end

get('/train') do
  erb(:new_train)
end

get('/routes/routes/train') do
  erb(:new_train)
end


post('/routes') do
  city_name = params['city']
  if city_name != nil
    city = City.new(:name => city_name)
    city.save
  else
    train = Train.new(:name => params['train'])
    train.save
  end
  @cities = City.all
  @trains = Train.all
  @schedule = Train.all_routes
  erb(:routes)
end

delete('/routes') do
  City.delete_schedule(params['schedule_id'].to_i)
  @cities = City.all
  @trains = Train.all
  @schedule = Train.all_routes
  erb(:routes)
end
