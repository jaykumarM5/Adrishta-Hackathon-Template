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
      name: parsedBody.name,
      votes: 0,
      eventid: parsedBody.eventid,
    };

    console.log(myobj);

    MongoClient.connect(url, function (err, db) {
      if (err) throw err;
      var dbo = db.db("iVoted");

      dbo
        .collection("candidates")
        .findOne(
          { cadid: name, eventid: parsedBody.eventid },
          function (err, result) {
            if (err) throw err;
            console.log(result);
            if (result == null) {
              dbo.collection("candidates").insertOne(myobj, function (err, res) {
                if (err) throw err;
                console.log("Log : 1 document inserted ");
                res.json({ status: "done" });
              });
            }else{
              res.json({ status: "exists" });
            }
          }
        );
    });
    
  }

  // var imgCntnt = dataUri.substring(0, 22);
};
