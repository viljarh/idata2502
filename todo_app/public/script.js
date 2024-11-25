async function fetchTodos() {
  const response = await fetch("/api/todos");
  const todos = await response.json();
  const todoList = document.getElementById("todoList");
  todoList.innerHTML = "";
  todos.forEach((todo) => {
    const li = document.createElement("li");
    li.innerHTML = `
            <span>${todo.task}</span>
            <button onclick="deleteTodo(${todo.id})">Delete</button>
        `;
    todoList.appendChild(li);
  });
}

async function addTodo() {
  const task = document.getElementById("todoInput").value;
  if (!task) return alert("Task cannot be empty");
  await fetch("/api/todos", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ task }),
  });
  document.getElementById("todoInput").value = "";
  fetchTodos();
}

async function deleteTodo(id) {
  await fetch(`/api/todos/${id}`, { method: "DELETE" });
  fetchTodos();
}

fetchTodos();
