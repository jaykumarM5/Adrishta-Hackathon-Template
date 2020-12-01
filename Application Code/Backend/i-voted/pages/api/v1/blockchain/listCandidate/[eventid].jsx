const MongoClient = require("mongodb").MongoClient;
var url = process.env.MONGO_SERVER;


export default (req,res) => {
    MongoClient.connect(url, function (err, db) {
        if (err) throw err;
        var dbo = db.db("iVoted");
        dbo
          .collection("candidates")
          .find({eventid : req.query.eventid})
          .toArray(function (err, result) {
            if (err) throw err;
            console.log(result);
            db.close();
            res.json(result);
          });
      });
}