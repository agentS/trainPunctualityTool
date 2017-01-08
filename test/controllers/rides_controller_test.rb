require "date"

class RidesControllerTest < AuthenticatedControllerTest
	DATE_TIME_FORMAT_PATTERN = "%Y-%m-%d %H:%M:%S %z"

	test "should create a new ride between Hagenberg and Mauer-Oehling" do
		departure_time_string = Time.now().strftime(DATE_TIME_FORMAT_PATTERN)
		arrival_time_string = (Time.now() + (2 * 60 * 60)).strftime(DATE_TIME_FORMAT_PATTERN)

		puts(@request.cookies)
		assert_difference("Ride.count") do
			post(rides_url, params: { ride: {
				departure_station: "Hagenberg", arrival_station: "Mauer-Oehling",
				departure_time: departure_time_string, arrival_time: arrival_time_string,
				departure_delay: 5, arrival_delay: 15
			}})

			puts(@response.status)
		end
	end

	test "update the arrival delay of a ride between Hagenberg and Mauer-Oehling" do
		departure_time_string = Time.now().strftime(DATE_TIME_FORMAT_PATTERN)
		arrival_time_string = (Time.now() + (2 * 60 * 60) + (5 * 60)).strftime(DATE_TIME_FORMAT_PATTERN)
		updated_arrival_delay = 20

		put(ride_url(298486374), params: { ride: {
				departure_station_id: 1, arrival_station_id: 2,
				departure_time: departure_time_string, arrival_time: arrival_time_string,
				departure_delay: 5, arrival_delay: updated_arrival_delay
			} })
		assert_response(:redirect)
	end

	test "avoid creation of invalid ride entries" do
		departure_time_string = Time.now().strftime(DATE_TIME_FORMAT_PATTERN)
		arrival_time_string = (Time.now() + (2 * 60 * 60)).strftime(DATE_TIME_FORMAT_PATTERN)

		assert_raises() do
			post(rides_url, params: { ride: {
				departure_station: "Hagenberg",
				departure_time: departure_time_string, arrival_time: arrival_time_string,
				departure_delay: 5, arrival_delay: 15
			}})
		end

		assert_no_difference("Ride.count") do
			post(rides_url, params: { ride: {
				departure_station: "Hagenberg", arrival_station: "Mauer-Oehling",
				departure_time: departure_time_string,
				departure_delay: 5, arrival_delay: 15
			}})
		end
	end
end
