class RidesController < AuthenticatedController
  def index()
    @rides = Ride.all()
  end

  def new()
    @ride = Ride.new()
  end

  def create()
    @ride = Ride.new(ride_parameters())
    @ride.departure_station = get_departure_station()
    @ride.arrival_station = get_arrival_station()

    if @ride.save() == true
      redirect_to("/dashboard/index")
    else
      render("new")
    end
  end

  def edit()
    @ride = Ride.find(params[:id])
  end

  def update()
    @ride = Ride.find(params[:id])
    @ride.departure_station = get_departure_station_by_id()
    @ride.arrival_station = get_arrival_station_by_id()

    if @ride.update(ride_parameters()) == true
      redirect_to(rides_path())
    else
      render("edit")
    end
  end

  def destroy()
    @ride = Ride.find(params[:id])
    @ride.destroy()

    redirect_to(rides_path())
  end

  private def ride_parameters()
    params.require(:ride).permit(:departure_time, :departure_delay, :arrival_time, :arrival_delay)
  end

  private def get_departure_station()
    departure_station_name = params[:ride][:departure_station]
    return load_or_create_station(departure_station_name)
  end

  private def get_arrival_station()
    arrival_station_name = params[:ride][:arrival_station]
    return load_or_create_station(arrival_station_name)
  end

  private def load_or_create_station(station_name)
    station = Station.find_by(name: station_name)
    if station == nil
      station = create_new_station(station_name)
    end
    return station
  end

  private def get_departure_station_by_id()
    departure_station_id = params[:ride][:departure_station_id]
    return load_station(departure_station_id)
  end

  private def get_arrival_station_by_id()
    arrival_station_id = params[:ride][:arrival_station_id]
    return load_station(arrival_station_id)
  end

  private def load_station(station_id)
    station = Station.find(station_id)
    return station
  end

  private def create_new_station(station_name)
    new_station = Station.new()
    new_station.name = station_name

    if new_station.save() == true
      return new_station
    else
      raise("Could not create the station #{station_name}.")
    end
  end
end
