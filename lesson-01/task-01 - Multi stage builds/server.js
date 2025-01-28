const http = require('http'); // Import the HTTP module

// Create the server
const server = http.createServer((req, res) => {
  if (req.url === '/') { // Check if the request is for the root URL
    res.writeHead(200, { 'Content-Type': 'text/plain' }); // Set response headers
    res.end('Hello World - this is my node.js project'); // Send "Hello World" as the response
  } else {
    res.writeHead(404, { 'Content-Type': 'text/plain' }); // Handle other URLs
    res.end('Not Found');
  }
});

// Start the server on port 80
server.listen(80, '0.0.0.0', () => {
  console.log('Server running at http://localhost:80/');
});

