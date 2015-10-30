# defmodule GrapheneTest do
#   use ExUnit.Case
#   doctest Graphene
#
#   defmodule User do
#     defstruct id: nil, name: nil
#   end
#
#   defmodule UserAdapter do
#     use Graphene.Adapter,
#       name: "users",
#       attributes: [
#         id: Graphene.Integer,
#         name: Graphene.String,
#       ]
#
#     def handle_query(filters, _projections) do
#       all_users = [
#         %User{ id: 1, name: "Alex" },
#         %User{ id: 2, name: "Alfred" },
#         %User{ id: 3, name: "Sam" },
#       ]
#
#       filtered_users = filters |> Enum.reduce(&UserAdapter.filter_users, all_users)
#
#       {:ok, filtered_users, nil}
#     end
#
#     defp filter_users({:id, id}, users) do
#       users |> Enum.filter(fn(user) ->
#         user.id == id
#       end)
#     end
#
#     defp filter_users(_filter, users) do
#       users
#     end
#   end
#
#   test "it can execute a query with filtering" do
#     results = Graphene.execute ~s"""
#     {
#       users(id: 2) {
#         id,
#         name,
#       }
#     }
#     """
#
#     assert results == %{
#       "users": [ %{ id: 2, name: "Alfred" } ]
#     }
#   end
# end
