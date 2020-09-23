defmodule HelloJcWeb.PageController do
  use HelloJcWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
