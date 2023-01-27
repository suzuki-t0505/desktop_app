defmodule DesktopAppWeb.PageController do
  use DesktopAppWeb, :controller

  def index(conn, _params) do
    IO.inspect("call index")
    tasks = DesktopApp.Tasks.get_tasks()
    render(conn, "index.html", tasks: tasks)
  end
end
