const express = require("express");
const sqlite3 = require("sqlite3").verbose();
const bodyParser = require("body-parser");
const cors = require("cors");

const app = express();
const db = new sqlite3.Database("./db.sqlite");

app.use(bodyParser.json());
app.use(cors());
app.use(express.static("public")); // Serve frontend files

db.serialize(() => {
  db.run(`
    CREATE TABLE IF NOT EXISTS todos (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      task TEXT,
      completed BOOLEAN
    )
  `);
});

app.get("/api/todos", (req, res) => {
  db.all("SELECT * FROM todos", (err, rows) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json(rows);
  });
});

app.post("/api/todos", (req, res) => {
  const { task } = req.body;
  db.run(
    "INSERT INTO todos (task, completed) VALUES (?, ?)",
    [task, false],
    function (err) {
      if (err) return res.status(500).json({ error: err.message });
      res.json({ id: this.lastID, task, completed: false });
    },
  );
});

app.put("/api/todos/:id", (req, res) => {
  const { id } = req.params;
  const { task, completed } = req.body;
  db.run(
    "UPDATE todos SET task = ?, completed = ? WHERE id = ?",
    [task, completed, id],
    function (err) {
      if (err) return res.status(500).json({ error: err.message });
      res.json({ id, task, completed });
    },
  );
});

app.delete("/api/todos/:id", (req, res) => {
  const { id } = req.params;
  db.run("DELETE FROM todos WHERE id = ?", id, function (err) {
    if (err) return res.status(500).json({ error: err.message });
    res.json({ message: "Todo deleted" });
  });
});

// Start the server
const PORT = 3000;
app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});
