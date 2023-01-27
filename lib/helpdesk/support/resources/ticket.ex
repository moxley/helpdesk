defmodule Helpdesk.Support.Ticket do
  # This turns this module into a resource
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "tickets"
    repo Helpdesk.Repo
  end

  actions do
    # Add a set of simple actions. You'll customize these later.
    defaults [:create, :read, :update, :destroy]

    create :open do
      # By default you can provide all public attributes to an action
      # This action should only accept the subject
      accept [:subject]
    end

    update :close do
      # We don't want to accept any input here
      accept []

      change set_attribute(:status, :closed)
      # A custom change could be added like so:
      #
      # change MyCustomChange
      # change {MyCustomChange, opt: :val}
    end

    update :assign do
      # No attributes should be accepted
      accept []

      # We accept a representative's id as input here
      argument :representative_id, :uuid do
        # This action requires representative_id
        allow_nil? false
      end

      # We use a change here to replace the related Representative
      # If there is a different representative for this Ticket, it will be changed to the new one
      # The Representative itself is not modified in any way
      change manage_relationship(:representative_id, :representative, type: :append_and_remove)
    end
  end

  # Attributes are the simple pieces of data that exist on your resource
  attributes do
    # Add an autogenerated UUID primary key called `:id`.
    uuid_primary_key :id

    # Add a string type attribute called `:subject`
    attribute :subject, :string do
      allow_nil? false
    end

    # status is either `open` or `closed`. We can add more statuses later
    attribute :status, :atom do
      # Constraints allow you to provide extra rules for the value.
      # The available constraints depend on the type
      # See the documentation for each type to know what constraints are available
      # Since atoms are generally only used when we know all of the values
      # it provides a `one_of` constraint, that only allows those values
      constraints one_of: [:open, :closed]

      # The status defaulting to open makes sense
      default :open

      # We also don't want status to ever be `nil`
      allow_nil? false
    end
  end

  relationships do
    # belongs_to means that the destination attribute is unique, meaning only one related record could exist.
    # We assume that the destination attribute is `representative_id` based
    # on the name of this relationship and that the source attribute is `representative_id`.
    # We create `representative_id` automatically.
    belongs_to :representative, Helpdesk.Support.Representative
  end
end
