defmodule Helpdesk.Plug.Router do
  use Plug.Router

  plug(Plug.Parsers, parsers: [:urlencoded, :multipart, :json], json_decoder: Jason)
  plug(:match)
  plug(:dispatch)

  forward("/gql",
    to: Absinthe.Plug,
    init_opts: [schema: Helpdesk.Absinthe.Schema]
  )

  forward("/playground",
    to: Absinthe.Plug.GraphiQL,
    init_opts: [
      schema: Helpdesk.Absinthe.Schema,
      interface: :playground
    ]
  )

  get "/" do
    send_resp(conn, 200, "Welcome")
  end

  match _ do
    send_resp(conn, 404, "Oops!")
  end
end
