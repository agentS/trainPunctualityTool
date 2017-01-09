require("date")

class DashboardController < AuthenticatedController
  LATEST_DELAYED_RIDE_SHOW_QUANTITY = 5

  def index()
    if get_treshold_date() == nil
      set_treshold_date(365)
    end

    @rides = Ride.all()

    get_punctuality_rate()
    get_latest_delayed_rides()
  end

  private def store_treshold_date(treshold_date)
    session[:treshold_date] = treshold_date 
  end

  private def get_treshold_date()
    treshold_date = session[:treshold_date]

    if treshold_date.class() == String
      return create_time_from_string(treshold_date)
    end

    return treshold_date
  end
  helper_method(:get_treshold_date)

  private def create_time_from_string(time_string)
    year = time_string[0..4]
    month = time_string[5..7]
    day = time_string[8..10]

    return Time.new(year, month, day)
  end

  private def set_treshold_date(scope_in_days)
    @observation_scope_in_days = scope_in_days
    treshold_date = Time.now() - (@observation_scope_in_days * 24 * 60 * 60)

    store_treshold_date(treshold_date)
  end

  private def is_ride_in_time_scope(ride)
    if ride.departure_time > get_treshold_date()
      return true
    end
    return false
  end

  private def get_punctuality_rate()
    delayed_rides = 0
    punctual_rides = 0
    @rides.each() do |processed_ride|
      if is_ride_in_time_scope(processed_ride) == true
        if is_ride_delayed(processed_ride) == true
          delayed_rides = delayed_rides + 1
        else
          punctual_rides = punctual_rides + 1
        end
      end
    end
    if (delayed_rides + punctual_rides) != 0
      @punctual_ride_ratio = (punctual_rides.to_f() / (delayed_rides+punctual_rides)) * 100
    else
      @punctual_ride_ratio = 0
    end
  end

  private def is_ride_delayed(ride)
    if (ride.arrival_delay != 0) || (ride.departure_delay != 0)
      return true
    else
      return false
    end
  end

  private def get_latest_delayed_rides()
    @latest_delayed_rides = Ride.where("arrival_delay > 0 OR departure_delay > 0")
      .limit(LATEST_DELAYED_RIDE_SHOW_QUANTITY)
      .order(departure_time: :desc)
  end

  def save_time_scope()
    new_treshold_date_string = params[:treshold_date]
    new_treshold_date_year = new_treshold_date_string[0..4]
    new_treshold_date_month = new_treshold_date_string[5..7]
    new_treshold_date_day = new_treshold_date_string[8..10]
    new_treshold = Time.new(new_treshold_date_year, new_treshold_date_month, new_treshold_date_day)
    
    store_treshold_date(new_treshold)

    redirect_to(dashboard_index_path())
  end
end
