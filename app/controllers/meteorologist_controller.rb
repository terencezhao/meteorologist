require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================
    
    geocodeUrl = "https://maps.googleapis.com/maps/api/geocode/json?address=" + @street_address
    parsed_address = JSON.parse(open(geocodeUrl).read)
    latitude = parsed_address["results"][0]["geometry"]["location"]["lat"]
    longitude = parsed_address["results"][0]["geometry"]["location"]["lng"]
    forecastUrl = "https://api.darksky.net/forecast/6842c74db30df2e42d7a490dc31acdd3/"+latitude.to_s+","+longitude.to_s
    parsed_forecast = JSON.parse(open(forecastUrl).read)

    @current_temperature = parsed_forecast.dig("currently","temperature")

    @current_summary = parsed_forecast.dig("currently","summary")

    @summary_of_next_sixty_minutes = parsed_forecast.dig("minutely","summary")

    @summary_of_next_several_hours = parsed_forecast.dig("hourly","summary")

    @summary_of_next_several_days = parsed_forecast.dig("daily","summary")

    render("meteorologist/street_to_weather.html.erb")
  end
end