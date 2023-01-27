defmodule Helpdesk.Support.Registry do
  use Ash.Registry,
    extensions: [
      # This extension adds helpful compile time validations
      Ash.Registry.ResourceValidations
    ]

  entries do
    entry Helpdesk.Support.Ticket
    entry Helpdesk.Support.Representative
  end
end
