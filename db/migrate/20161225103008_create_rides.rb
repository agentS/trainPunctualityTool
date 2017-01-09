class CreateRides < ActiveRecord::Migration[5.0]
  # multiple references: https://stackoverflow.com/questions/2057210/ruby-on-rails-reference-the-same-model-twice
  def change
    create_table :rides do |t|
      t.datetime :departure_time
      t.datetime :arrival_time
      t.integer :departure_delay
      t.integer :arrival_delay
      t.references :departure_station
      t.references :arrival_station

      t.timestamps
    end
  end
end
