const http = require('http');
const port = 3000;

const randInt = (num) => {
  return Math.ceil(Math.random() * num);
};

const handler = (req, res) => {
  res.writeHead(200, {
    'Content-Type': 'text/event-stream',
    'Cache-Control': 'no-cache',
    'Connection': 'keep-alive'
  });
  // id is Date.now, event is number
  (function loop() {
    res.write(`id: ${Date.now()}\n`);
    res.write('event: number\n');
    res.write(`data: ${JSON.stringify({number: randInt(100)})}\n\n`);
    setTimeout(loop, randInt(1000));
  })();
};

const server = http.createServer(handler);

server.listen(port, (err) => {
  if (err) {
    return console.log('Something bad happened');
  }
  console.log(`Server is listening on port ${port}`);
});
