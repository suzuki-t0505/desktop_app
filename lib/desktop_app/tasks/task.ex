defmodule DesktopApp.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :task_name, :string
    field :completed, :boolean

    timestamps()
  end

  def changeset(task, params \\ %{}) do
    task
    |> cast(params, [:task_name, :completed])
    |> validate_required([:task_name, :completed])
  end

  def build_changeset() do
    cast(%__MODULE__{}, %{}, [:task_name, :completed])
  end
end
