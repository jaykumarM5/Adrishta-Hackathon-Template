const MongoClient = require("mongodb").MongoClient;
var url = process.env.MONGO_SERVER;

export default async (req, res) => {
  MongoClient.connect(url, function (err, db) {
    if (err) throw err;
    var dbo = db.db("iVoted");
    dbo.collection("voters").findOne({"user" : req.query.voter}, function (err, result) {
      if (err) throw err;
      console.log(result.lb);
      db.close();
      res.json({lastBlock : result.lb})
    });
  });
};
