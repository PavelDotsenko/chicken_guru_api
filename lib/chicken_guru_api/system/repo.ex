defmodule CG.Repo do
  use Ecto.Repo,
    otp_app: :chicken_guru_api,
    adapter: Ecto.Adapters.Postgres
end
