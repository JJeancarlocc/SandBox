defmodule HelloJc.Repo do
  use Ecto.Repo,
    otp_app: :hello_jc,
    adapter: Ecto.Adapters.Postgres
end
