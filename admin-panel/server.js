require('dotenv').config();
const express = require('express');
const path = require('path');

const app = express();
const PORT = process.env.ADMIN_PORT || 5000;

// Serve static files
app.use(express.static(path.join(__dirname, 'public')));

// Routes
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

app.get('/players', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'players.html'));
});

app.get('/products', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'products.html'));
});

app.get('/shops', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'shops.html'));
});

app.listen(PORT, () => {
  console.log(`Admin Panel running on http://localhost:${PORT}`);
});
