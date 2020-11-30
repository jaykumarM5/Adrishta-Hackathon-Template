const MongoClient = require("mongodb").MongoClient;
var url = process.env.MONGO_SERVER;

export default async (req, res) => {
  var parsedBody = JSON.parse(req.body);
  if (req.method == "POST") {
    var myobj = {
      created: new Date(),
      fromDate: parsedBody.from,
      toDate: parsedBody.to,
      event: parsedBody.name,
    };

    MongoClient.connect(url, function (err, db) {
      if (err) throw err;
      var dbo = db.db("iVoted");
      dbo.collection("events").insertOne(myobj, function (err, res) {
        if (err) throw err;
        console.log("Log : 1 document inserted ");
      });
    });
  }
  res.json({ status: "done" });
};
