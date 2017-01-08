require 'test_helper'
require "date"

class StationTest < ActiveSupport::TestCase
	test "the station name has to be composed of at least three characters" do
		demo_station = Station.new()
		assert_not(demo_station.save(), "The station name has to be composed of at least three characters.")
	end

	test "generate a ride between two stations" do
		departure_station = create_station("Hagenberg")
		assert(departure_station.save(), "Could not create the departure station.")
		assert_equal("Hagenberg", Station.find(departure_station.id).name,
			"The departure station is not saved correctly.")

		arrival_station = create_station("Mauer-Oehling")
		assert(arrival_station.save(), "Could not create the arrival station.")

		ride_home = Ride.new()
		ride_home.departure_station = departure_station
		ride_home.arrival_station = arrival_station
		ride_home.departure_delay = 5
		ride_home.arrival_delay = 0
		ride_home.departure_time = Time.now()
		ride_home.arrival_time = (Time.now() + (2 * 60 * 60))
		assert(ride_home.save(), "Could not create the ride record representing a journey home.")
	end

	def create_station(station_name)
		new_station = Station.new()
		new_station.name = station_name
		return new_station
	end
end
