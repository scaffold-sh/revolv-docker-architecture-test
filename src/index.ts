import express from "express"

const app = express()
const port = 8080

app.get("/", (_req, res) => {
  res.send("Hello from Revolv! " + process.env.B + " - " + process.env.A)
})

app.listen(port)

console.log(`Running on http://localhost:${port}`)
