defmodule TbeElixir.Repo do
  use Ecto.Repo, otp_app: :tbe_elixir

  @doc """
  Dynamically loads the repository url from the
  DATABASE_URL environment variable.
  """
end
