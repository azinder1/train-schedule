class City
attr_reader(:name, :id)

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes.fetch(:id, nil)
  end

  def self.all
    return_cities = DB.exec("SELECT * FROM cities;")
    cities = []
    return_cities.each do |city|
      current_city = City.new(:name => city['name'], :id => city['id'].to_i)
      cities.push(current_city)
    end
    cities
  end

  def save
    result = DB.exec("INSERT INTO cities(name) Values ('#{@name}') RETURNING id;")
    @id = result.first["id"].to_i
  end

  def self.find(id)
    found_city = DB.exec("SELECT * FROM cities WHERE id = '#{id}'").first()
    City.new(:name => found_city['name'], :id => found_city['id'].to_i)
  end

  def ==(another_city)
    self.name == another_city.name
  end

  def update(attributes)
    @id = self.id()
    @name = attributes.fetch(:name, @name)
    update_result = DB.exec("UPDATE cities SET name = '#{@name}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM cities WHERE id = #{self.id()};")
  end
end
