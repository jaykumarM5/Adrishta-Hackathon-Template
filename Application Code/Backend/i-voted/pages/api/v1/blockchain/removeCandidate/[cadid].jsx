const MongoClient = require("mongodb").MongoClient;
var url = process.env.MONGO_SERVER;

export default async (req, res) => {
  MongoClient.connect(url, function (err, db) {
    if (err) throw err;
    var dbo = db.db("iVoted");
    
    var myquery = { cadid: req.query.cadid };
    dbo.collection("candidates").deleteOne(myquery, function(err, obj) {
      if (err) throw err;
      console.log("1 document deleted");
      db.close();
    });
  });
  res.json({ status: "deleted" });
};