defmodule GrapheneParserTest do
  use ExUnit.Case
  doctest Graphene.Parser

  test "it can parse a basic collection query" do
    {:ok, ast} = Graphene.Parser.parse ~s"""
    {
      users {
        id,
        name,
      }
    }
    """

    assert ast == [
      {:query_def, [
        {:query, %{
          "name": "users",
          "alias": "users",
          "filters": [],
          "projections": ["id", "name"],
        }}
      ]}
    ]
  end
end
