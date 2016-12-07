require('spec_helper')
require('pry-nav')

describe(City) do

  describe(".all") do
    it('starts off with no movies') do
      expect(City.all).to(eq([]))
    end
  end

  describe(".find") do
    it('returns a city by its ID number') do
      city1 = City.new(:name => "NY, NY")
      city1.save
      city2 = City.new(:name => "Chi Town, IL")
      city2.save
      expect(City.find(city1.id)).to(eq(city1))
    end
  end

  describe("#==") do
    it ('compares two objects by name') do
      city1 = City.new(:name => "NY, NY")
      city1.save
      city2 = City.new(:name => "NY, NY")
      city2.save
      expect(city1.==(city2)).to(eq(true))
    end
  end
  describe("#update") do
    it("can update a city in the database") do
      city1 = City.new(:name => "NY, NY")
      city1.save
      city1.update({:name => "Detroit, Detroit"})
      expect(city1.name).to(eq("Detroit, Detroit"))
    end
  end

  describe("#delete") do
    it('lest you delete a city from the database') do
      city1 = City.new(:name => "NY, NY")
      city1.save
      city2 = City.new(:name => "Chi Town, IL")
      city2.save
      city1.delete
      expect(City.all).to(eq([city2]))
    end
  end
end
