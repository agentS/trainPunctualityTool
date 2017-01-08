Rails.application.routes.draw do
	get("log_out" => "sessions#destroy", :as => "log_out")
	get("log_in" => "sessions#new", :as => "log_in")


	get("dashboard/index")
	post("dashboard/save_time_scope")

	resources(:rides)
	resources(:stations)
	resources(:users)
	resources(:sessions)

	root("application#index")
end
