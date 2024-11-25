const request = require("supertest");
const app = require("../server"); // This should point to the updated server.js file

describe("Todo API Endpoints", () => {
  it("GET /api/todos should return an empty array", async () => {
    const res = await request(app).get("/api/todos");
    expect(res.statusCode).toBe(200);
    expect(res.body).toEqual([]);
  });

  it("POST /api/todos should add a new todo", async () => {
    const newTodo = { task: "Test Todo" };
    const res = await request(app).post("/api/todos").send(newTodo);
    expect(res.statusCode).toBe(200);
    expect(res.body.task).toBe("Test Todo");
  });
});
