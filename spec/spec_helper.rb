require("rspec")
require("pg")
require("city")
require("train")

DB = PG.connect({:dbname => "trains_schedule_test"})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM cities *;")
    DB.exec("DELETE FROM trains *;")
    DB.exec("DELETE FROM schedules *;")
  end
end
