defmodule DesktopApp do
  use Application

  def config_dir() do
    Path.join([Desktop.OS.home(), ".config", "desktop_app"])
  end

  # appモジュールにこのプロジェクトの名前を割当
  @app Mix.Project.config()[:app]
  def start(:normal, []) do
    File.mkdir_p!(config_dir())
    # DB周り
    {:ok, sup} = Supervisor.start_link([DesktopApp.Repo], name: __MODULE__, strategy: :one_for_one)
    # PubSubとEndpoint, session周り
    {:ok, _} = Supervisor.start_child(sup, DesktopAppWeb.Sup)
    # Desktop周り
    {:ok, _} =
      Supervisor.start_child(sup, {
        Desktop.Window,
        [
          app: @app,
          id: DesktopAppWindow,
          title: "todo",
          size: {400, 800},
          url: &DesktopAppWeb.Endpoint.url/0
        ]
      })
  end
end
