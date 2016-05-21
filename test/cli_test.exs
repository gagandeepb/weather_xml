defmodule CliTest do
  use ExUnit.Case
  doctest WeatherXml

  import WeatherXml.CLI, only: [ parse_args: 1 ]

  test ":help returned by option parsing with -h and --help options" do
    assert parse_args(["-h",     "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help
  end

  test "one value returned if one given" do
    assert parse_args(["my_location_code"]) == "my_location_code"
  end
end
