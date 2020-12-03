const IpfsHttpClient = require("ipfs-http-client");
const MongoClient = require("mongodb").MongoClient;
var url = process.env.MONGO_SERVER;

export default async (req, res) => {
  MongoClient.connect(url, function (err, db) {
    if (err) throw err;
    var dbo = db.db("iVoted");
    var votedToArray = [];
    var details = {
      voter: req.query.voter,
      votedTo: req.query.cadid,
      date: new Date(),
    };

    dbo.collection("voteHistory").insertOne(details, function (err, res) {
      if (err) throw err;
      console.log("1 document inserted");
    });
    dbo.collection("voters").updateOne(
      { user: req.query.voter },
      {
        $push: {
          votedTo: req.query.eventid,
        },
      },
      function (err, res) {
        if (err) throw err;
        console.log("1 document Updated");
      }
    );
    db.close();
    res.json({ status: "updated" });
  });
};
