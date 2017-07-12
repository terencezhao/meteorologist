require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("forecast/coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]

    # ==========================================================================
    # Your code goes below.
    # The latitude the user input is in the string @lat.
    # The longitude the user input is in the string @lng.
    # ==========================================================================

    url = "https://api.darksky.net/forecast/6842c74db30df2e42d7a490dc31acdd3/"+@lat+","+@lng #37.8267,-122.4233
    parsed_data = JSON.parse(open(url).read)

    @current_temperature = parsed_data.dig("currently","temperature").to_s

    @current_summary = parsed_data.dig("currently","summary").to_s

    @summary_of_next_sixty_minutes = parsed_data.dig("minutely","summary").to_s

    @summary_of_next_several_hours = parsed_data.dig("hourly","summary").to_s

    @summary_of_next_several_days = parsed_data.dig("daily","summary").to_s

    render("forecast/coords_to_weather.html.erb")
  end
end