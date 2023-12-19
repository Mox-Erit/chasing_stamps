defmodule ChasingStamps.Repo do
  use Ecto.Repo,
    otp_app: :chasing_stamps,
    adapter: Ecto.Adapters.Postgres
end
