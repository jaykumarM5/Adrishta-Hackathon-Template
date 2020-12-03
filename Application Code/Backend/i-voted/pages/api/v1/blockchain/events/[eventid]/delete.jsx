import { ObjectID } from "mongodb";

const MongoClient = require("mongodb").MongoClient;
var url = process.env.MONGO_SERVER;

export default async (req, res) => {
  MongoClient.connect(url, function (err, db) {
    if (err) throw err;
    var dbo = db.db("iVoted");
    var myquery = { _id: ObjectID(req.query.eventid) };
    dbo.collection("events").deleteOne(myquery, function (err, obj) {
      if (err) throw err;
      console.log("1 document deleted" + obj);
      db.close();
      res.json({status:"done",query:obj})
    });
  });
};
