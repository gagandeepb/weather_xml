defmodule WeatherXml.OutputFormatter do
  use Tabula, style: :github_md
  def pretty_table(my_map_list) do
    my_map_list
    |> Enum.map(&zip_tuples/1)
    |> print_table
  end

  def zip_tuples(my_map_elem) do
    my_key_elem = List.to_string(Map.keys(my_map_elem))
    my_value_elem = List.to_string(Map.values(my_map_elem))
    %{ "Keys" => my_key_elem, "Values" => my_value_elem }
  end
end
