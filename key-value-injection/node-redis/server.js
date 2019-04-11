const express = require('express');
const app = express();
const redis = require('redis');
const {promisify} = require('util');
const client = redis.createClient(process.env.REDIS_URL);

var bodyParser = require('body-parser');
// parse application/x-www-form-urlencoded
app.use(bodyParser.urlencoded())

// parse application/json
app.use(bodyParser.json())


app.get('/', (req, res) => {
  client.get(req.query.key, function (error, result) {
    if (error) {
        console.log(error);
        throw error;
    }
    console.log('GET result ->' + result);
    console.log('Express version: ' + require('express/package').version);
  return res.send('Your value is: ' + result);
});
});

app.post('/', function (req, res) {
  console.log(req.body);
  client.set(req.body.key, "default");
  return res.send('Done');
});
// GET with ?key[]=test&key=pwned
app.get('/query', function (req, res) {
  console.log(req.query.key);  
  client.set(req.query.key, "default");
  return res.send('Done');
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server listening on port ${PORT}`);
});
