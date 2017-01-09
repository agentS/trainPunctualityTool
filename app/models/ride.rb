class Ride < ApplicationRecord
  # multiple references: https://stackoverflow.com/questions/2057210/ruby-on-rails-reference-the-same-model-twice
  belongs_to :departure_station, :class_name => "Station"
  belongs_to :arrival_station, :class_name => "Station"

  validates(:departure_delay, presence: true)
  validates(:arrival_delay, presence: true)
  
  validates(:departure_time, presence: true)
  validates(:arrival_time, presence: true)
end
