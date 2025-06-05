const express = require("express");
const client = require("prom-client");

const app = express();
const PORT = process.env.PORT || 3000;

// Register Prometheus metrics
const register = new client.Registry();
client.collectDefaultMetrics({ register });

// Root route
app.get("/", (req, res) => {
  res.send("Hello from Signiance Node.js App!");
});

// Metrics route for Prometheus to scrape
app.get("/metrics", async (req, res) => {
  res.set('Content-Type', register.contentType);
  res.end(await register.metrics());
});

// Start server
app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});
