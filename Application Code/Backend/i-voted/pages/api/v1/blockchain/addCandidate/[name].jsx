const MongoClient = require("mongodb").MongoClient;
const IpfsHttpClient = require("ipfs-http-client");
var url = process.env.MONGO_SERVER;


export default (req, res) => {
  const ipfs = IpfsHttpClient({
    timeout: 10000,
    host: "ipfs.infura.io",
    port: "5001",
    protocol: "https",
  });
  var name = req.query.name;
  var parsedBody = JSON.parse(req.body);
  if (req.method == "POST") {
    var myobj = {
      cadid: name,
      year: new Date().getFullYear(),
      bio: parsedBody.bio,
      dp: parsedBody.Symbol,
      name: parsedBody.name,
    };

    console.log(myobj);

    MongoClient.connect(url, function (err, db) {
      if (err) throw err;
      var dbo = db.db("iVoted");
      dbo.collection("candidates").insertOne(myobj, function (err, res) {
        if (err) throw err;
        console.log("Log : 1 document inserted ");
      });
    });
    res.json({ status: "done" });
  }

  // var imgCntnt = dataUri.substring(0, 22);
};
