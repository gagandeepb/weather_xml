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

  def convert_to_list_of_maps(list) do
    list
    |> Enum.map(&Enum.into(&1, Map.new))
  end

  def xml_parser(xml_body) do
    xml_body
    |> String.split("\n")
    |> Enum.map(&field_extractor/1)
  end

  def field_extractor(xml_line) do
    cond do
      Regex.match?(~r/<location>/, xml_line) -> %{"location" => gets_field(xml_line)}
      Regex.match?(~r/<station_id>/, xml_line) -> %{"station_id" => gets_field(xml_line)}
      Regex.match?(~r/<temperature_string>/, xml_line) -> %{"temperature_string" => gets_field(xml_line)}
      true -> %{ "yet_to_be_captured" => "XYZ"}
    end
  end

  def gets_field(xml_line) do
    xml_line
    |> :binary.split("</")
    |> List.first
    |> :binary.split(">")
    |> List.last
  end

  def remove_blanks(%{"yet_to_be_captured" => "XYZ"}), do: :false
  def remove_blanks(_elem), do: :true

end
