# WeatherXml

**TODO: Add description**

## TODO

* Additional modules to return list of all cities, with corresponding station_id
* Write tests for all untested modules
* Include more Weather data fields
* Parse XML in a better way, auto-extracting all extractable fields
* Document this code using Ex-Doc
* Better Error logging using Logger
* **Publish on GitHub**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add weather_xml to your list of dependencies in `mix.exs`:

        def deps do
          [{:weather_xml, "~> 0.0.1"}]
        end

  2. Ensure weather_xml is started before your application:

        def application do
          [applications: [:weather_xml]]
        end
