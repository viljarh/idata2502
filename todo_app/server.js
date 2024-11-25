const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");

const app = express();
app.use(bodyParser.json());
app.use(cors());
app.use(express.static("public")); // Serve frontend files

// In-memory "database" for todos
const todos = [];
let idCounter = 1;

app.get("/", (req, res) => {
  res.sendFile(__dirname + "/public/index.html");
});
// Get all todos
app.get("/api/todos", (req, res) => {
  res.json(todos);
});

// Add a new todo
app.post("/api/todos", (req, res) => {
  const { task } = req.body;
  if (!task) {
    return res.status(400).json({ error: "Task cannot be empty" });
  }
  const newTodo = { id: idCounter++, task, completed: false };
  todos.push(newTodo);
  res.json(newTodo);
});

// Update a todo
app.put("/api/todos/:id", (req, res) => {
  const { id } = req.params;
  const { task, completed } = req.body;
  const todo = todos.find((t) => t.id === parseInt(id));
  if (!todo) {
    return res.status(404).json({ error: "Todo not found" });
  }
  todo.task = task ?? todo.task;
  todo.completed = completed ?? todo.completed;
  res.json(todo);
});

// Delete a todo
app.delete("/api/todos/:id", (req, res) => {
  const { id } = req.params;
  const index = todos.findIndex((t) => t.id === parseInt(id));
  if (index === -1) {
    return res.status(404).json({ error: "Todo not found" });
  }
  todos.splice(index, 1);
  res.json({ message: "Todo deleted" });
});

// Start the server
const PORT = 3000;
const HOST = "0.0.0.0";
app.listen(PORT, HOST, () => {
  console.log(`Server running on http://${HOST}:${PORT}`);
});
