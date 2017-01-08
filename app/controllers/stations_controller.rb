class StationsController < AuthenticatedController
	def index()
		@stations = Station.all()
	end

	def edit()
		@station = Station.find(params[:id])
	end

	def update()
		@station = Station.find(params[:id])

		if @station.update(station_parameters())
			redirect_to(stations_path())
		else
			render("edit")
		end
	end

	def destroy()
		@station = Station.find(params[:id])
		@station.destroy()

		redirect_to(stations_path())
	end

	private def station_parameters()
		params.require(:station).permit(:name)
	end
end
