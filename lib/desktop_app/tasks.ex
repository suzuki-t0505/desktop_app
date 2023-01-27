defmodule DesktopApp.Tasks do
  alias DesktopApp.Repo
  alias DesktopApp.Tasks.Task

  def get_tasks() do
    Repo.all(Task)
  end

  def get_task(id) do
    Repo.get(Task, id)
  end

  def create_task(params) do
    %Task{}
    |> Task.changeset(params)
    |> Repo.insert()
  end

  def update_task(id, params) do
    id
    |> get_task()
    |> Task.changeset(params)
    |> Repo.update()
  end

  def delete_task(id) do
    id
    |> get_task()
    |> Repo.delete()
  end
end
