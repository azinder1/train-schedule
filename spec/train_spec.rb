require('spec_helper')
require('pry-nav')

describe(Train) do

  describe(".all") do
    it('starts off with no movies') do
      expect(Train.all).to(eq([]))
    end
  end

  describe(".find") do
    it('returns a city by its ID number') do
      train1 = Train.new(:name => "Choo choo choose you")
      train1.save
      train2 = Train.new(:name => "Tommy the train")
      train2.save
      expect(Train.find(train1.id)).to(eq(train1))
    end
  end

  describe("#==") do
    it ('compares two objects by name') do
      train1 = Train.new(:name => "Choo choo choose you")
      train1.save
      train2 = Train.new(:name => "Choo choo choose you")
      train2.save
      expect(train1.==(train2)).to(eq(true))
    end
  end
  describe("#update") do
    it("can update a train in the database") do
      train1 = Train.new(:name => "Choo choo choose you")
      train1.save
      train1.update({:name => "Tommy the train"})
      expect(train1.name).to(eq("Tommy the train"))
    end
    it("lets you add an city to a train") do
      train = Train.new(:name => "Herald Blue Line")
      train.save
      city1 = City.new(:name => "NY, NY")
      city1.save
      city2 = City.new(:name => "Chi Town, IL")
      city2.save
      train.update({:city_ids => [city1.id, city2.id], :times => ['1992-05-01 00:00:00', '1993-05-01 00:00:00']})
      expect(train.cities()).to(eq([city1, city2]))
    end
  end

  describe("#cities") do
    it("lets you return cities of particular trains") do
      train = Train.new(:name => "Herald Blue Line")
      train.save
      city1 = City.new(:name => "NY, NY")
      city1.save
      city2 = City.new(:name => "Chi Town, IL")
      city2.save
      train.update({:city_ids => [city1.id, city2.id], :times => ['1992-05-01 00:00:00', '1993-05-01 00:00:00']})
      expect(train.cities()).to(eq([city1, city2]))
    end
  end

  describe("#delete") do
    it('lest you delete a train from the database') do
      train1 = Train.new(:name => "Choo choo choose you")
      train1.save
      train2 = Train.new(:name => "Tommy the train")
      train2.save
      train1.delete
      expect(Train.all).to(eq([train2]))
    end
  end
end
