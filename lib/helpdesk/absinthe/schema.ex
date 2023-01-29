defmodule Helpdesk.Absinthe.Schema do
  use Absinthe.Schema

  @apis [Helpdesk.Api]

  use AshGraphql, apis: @apis

  # The query and mutation blocks is where you can add custom absinthe code
  query do
    field :blank, :string do
      resolve(fn _, _, _ -> {:ok, ""} end)
    end
  end

  mutation do
  end

  def context(ctx) do
    AshGraphql.add_context(ctx, @apis)
  end

  def plugins() do
    [Absinthe.Middleware.Dataloader | Absinthe.Plugin.defaults()]
  end
end
