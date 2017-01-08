class Station < ApplicationRecord
	# multiple references: https://stackoverflow.com/questions/2057210/ruby-on-rails-reference-the-same-model-twice
	has_many :departure_stations, :class_name => "Ride", :foreign_key => :departure_station_id
	has_many :arrival_stations, :class_name => "Ride", :foreign_key => :arrival_station_id

	validates(:name, presence: true, length: { minimum: 5 })
end
