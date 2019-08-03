class SearchesController < ApplicationController

  def search
  end

  def foursquare
    @response = Faraday.get "https://api.foursquare.com/v2/venues/search" do |request|
      request.params["client_id"] = "client_id"
      request.params["client_secret"] = "client_secret"
      request.params["v"] = "20160201"
      request.params["near"] = params[:zipcode]
      request.params["query"] = "coffee shop"
      # request.options.timeout = 0
    end

    body = JSON.parse(@response.body)

    if @response.success?
      @venues = body["response"]["venues"]
    else
      @error = body["meta"]["errorDetail"]
    end

    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    end

    render "search"
  end

end
