defmodule Helpdesk.Support.TicketTest do
  use ExUnit.Case, async: true
  # alias Helpdesk.Support.Ticket

  test "metadata is in the result" do
    resp =
      """
      mutation CreateTicket($input: CreateTicketInput!) {
        createTicket(input: $input) {
          result{
            subject
          }
          errors{
            message
          }
        }
      }
      """
      |> Absinthe.run(Helpdesk.Absinthe.Schema,
        variables: %{"input" => %{"subject" => "foobar"}}
      )

    assert {:ok, result} = resp

    refute Map.has_key?(result, :errors)

    assert %{
             data: %{
               "createTicket" => %{
                 "result" => %{
                   "subject" => "foobar"
                 }
               }
             }
           } = result
  end
end
