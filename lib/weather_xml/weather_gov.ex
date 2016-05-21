defmodule WeatherXml.WeatherGov do
  def fetch(location_code) do
    location_code
    |> issues_url
    |> HTTPoison.get
    |> handle_response
  end

  def issues_url(location_code) do
    "http://w1.weather.gov/xml/current_obs/#{location_code}.xml"
  end

  def handle_response({:ok, %{status_code: 200, body: body}}) do
    {:ok, body}
  end

  def handle_response({:ok, %{status_code: 404}}) do
    {:error404, "Location not found. :("}
  end

  def handle_response({:error, %{reason: reason}}) do
    {:error, reason}
  end
end
