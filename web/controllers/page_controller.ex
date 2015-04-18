defmodule DeployPhoenix.PageController do
  use DeployPhoenix.Web, :controller

  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end
end
