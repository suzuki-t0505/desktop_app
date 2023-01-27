defmodule DesktopAppWeb.TaskLive do
  use DesktopAppWeb, :live_view
  alias DesktopApp.Tasks

  def render(assigns), do: DesktopAppWeb.TaskView.render(assigns.template, assigns)

  def mount(_params, _session, socket) do
    IO.inspect("call mount")

    socket =
      socket
      |> assign(:tasks, Tasks.get_tasks())
      |> assign(:new_changeset, Tasks.Task.build_changeset())
      |> assign(:edit_changeset, Tasks.Task.build_changeset())
      |> assign(:mode, :index)
      |> assign(:page_title, "ToDo")
      |> assign(:template, "main.html")

    {:ok, socket}
  end

  def handle_event("toggle_insert", %{"task" => params}, socket) do
    params
    |> Map.merge(%{"completed" => false})
    |> Tasks.create_task()

    socket = assign(socket, :tasks, Tasks.get_tasks())

    {:noreply, socket}
  end

  def handle_event("toggle_completed", %{"id" => id}, socket) do
    task = Tasks.get_task(id)

    Tasks.update_task(id, %{completed: !task.completed})

    socket = assign(socket, :tasks, Tasks.get_tasks())

    {:noreply, socket}
  end

  def handle_event("toggle_edit", %{"id" => id}, socket) do
    task = Tasks.get_task(id)

    socket =
      socket
      |> assign(:edit_changeset, Tasks.Task.changeset(task))
      |> assign(:mode, :edit)

    {:noreply, socket}
  end

  def handle_event("toggle_cancel", _params, socket) do
    socket =
      socket
      |> assign(:edit_changest, Tasks.Task.build_changeset())
      |> assign(:mode, :index)

    {:noreply, socket}
  end

  def handle_event("toggle_update", %{"task" => params}, socket) do
    id = Map.get(params, "id", 0)
    Tasks.update_task(id, params)

    socket =
      socket
      |> assign(:tasks, Tasks.get_tasks())
      |> assign(:mode, :index)
      |> assign(:edit_changeset, Tasks.Task.build_changeset())

    {:noreply, socket}
  end

  def handle_event("toggle_delete", %{"id" => id}, socket) do
    Tasks.delete_task(id)

    socket = assign(socket, :tasks, Tasks.get_tasks())

    {:noreply, socket}
  end
end
