class Train
attr_reader(:name, :id)

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes.fetch(:id, nil)
  end

  def self.all
    return_trains = DB.exec("SELECT * FROM trains;")
    trains = []
    return_trains.each do |train|
      current_train = Train.new(:name => train['name'], :id => train['id'].to_i)
      trains.push(current_train)
    end
    trains
  end

  def save
    result = DB.exec("INSERT INTO trains(name) Values ('#{@name}') RETURNING id;")
    @id = result.first["id"].to_i
  end

  def self.find(id)
    found_train = DB.exec("SELECT * FROM trains WHERE id = '#{id}'").first()
    Train.new(:name => found_train['name'], :id => found_train['id'].to_i)
  end

  def ==(another_train)
    self.name == another_train.name
  end

  def update(attributes)
    @name = attributes.fetch(:name, @name)
    DB.exec("UPDATE trains SET name = '#{@name}' WHERE id = #{self.id()};")
    @time = attributes.fetch(:times, [])
    attributes.fetch(:city_ids, []).each do |city_id|
      current_time = @time.shift
      DB.exec("INSERT INTO schedules (city_ids, train_ids, times) VALUES (#{city_id}, #{self.id}, '#{current_time}');")
    end
  end

  def cities
    schedule = []
    id_returns = DB.exec("SELECT city_ids FROM schedules WHERE train_ids = '#{self.id}';")
    id_returns.each do |id_return|
      city_id = id_return.fetch("city_ids").to_i
      city = DB.exec("Select * From cities Where id = '#{city_id}';")
      name = city.first().fetch('name')
      schedule.push(City.new(:name => name, :id => city_id))
    end
    # binding.pry
    schedule
  end

  def delete
    DB.exec("DELETE FROM trains WHERE id = #{self.id()};")
  end

  def self.all_routes
    return_schedules = DB.exec("SELECT * FROM schedules;")
    schedule = return_schedules.to_a
  end

  def self.find_schedule(route_id)
    DB.exec("SELECT * FROM schedules WHERE id = #{route_id};")
  end

end
