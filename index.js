let express = require("express");
let bodyParser = require("body-parser");
let app = express();
const Routes = require('./routes/routes');


//Allow all requests from all domains & localhost
app.all("/*", function (req, res, next) {
  res.header("Access-Control-Allow-Origin", "*");
  res.header(
    "Access-Control-Allow-Headers",
    "X-Requested-With, Content-Type, Accept"
  );
  res.header("Access-Control-Allow-Methods", "POST, GET");
  next();
});

app.use(Routes);

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

let port = 4000;
app.listen(port, () => {
  console.log(`Running at localhost:${port}`);
});
