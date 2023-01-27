defmodule DesktopApp.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :task_name, :string
      add :completed, :boolean

      timestamps()
    end
  end
end
