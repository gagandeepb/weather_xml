defmodule WeatherXml.CLI do

  @moduledoc """
  Handle the command line parsing and the dispatch to
  the various functions that end up generating a
  table of the weather conditions at a given location
  """

  def run(argv) do
    argv
    |> parse_args
    |> process
  end

  @doc """
  `argv` can be -h or --help, which returns :help.

  Otherwise it is a 4-letter location code

  Return a string of "location_code", or `:help` if help was given.
  """
  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [ help: :boolean],
                                     aliases:  [ h:    :help   ])
    case  parse  do

    { [ help: true ], _, _ }
      -> :help

    { _, location_code, _ }
      -> List.to_string(location_code)

    _ -> :help

    end
  end

  def process(:help) do
    IO.puts """
    usage:  weather_xml <location_code>
    """
    System.halt(0)
  end

  def process(location_code) do
    WeatherXml.WeatherGov.fetch(location_code)
    |> decode_response
  end

  def decode_response({:ok, body}), do: body
  def decode_response({:error404, error_message}) do
    IO.puts error_message
    System.halt(2)
  end
  def decode_response({:error, reason}) do
    IO.inspect reason
    System.halt(4)
  end 

end
