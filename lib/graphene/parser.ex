defmodule Graphene.Parser do
  def parse(string) do
    string |> tokenize |> build_ast
  end

  defp tokenize(string) do
    string |> String.to_char_list |> :graphql_lexer.string
  end

  defp build_ast({:ok, tokens, _}) do
    :graphql_parser.parse(tokens)
  end

  defp build_ast(other) do
    other
  end
end
