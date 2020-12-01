const IpfsHttpClient = require("ipfs-http-client");
const MongoClient = require("mongodb").MongoClient;
var url = process.env.MONGO_SERVER;

export default async (req, res) => {
  const ipfs = IpfsHttpClient({
    timeout: 10000,
    host: "ipfs.infura.io",
    port: "5001",
    protocol: "https",
  });
  var file;
  MongoClient.connect(url, async function (err, db) {
    if (err) throw err;
    var dbo = db.db("iVoted");

    var allData = [];

    allData[0] = { snapshotTime: new Date() };

    dbo
      .collection(req.query.collection)
      .find({})
      .toArray(async function (err, result) {
        if (err) throw err;
        console.log(result);
        allData[1] = { collection: req.query.collection, records: result };
        file = await ipfs.add(JSON.stringify(allData));
        console.log("Log : Uploaded to IPFS > " + JSON.stringify(allData));
        console.log(file.path);
        var myobj = {
          collection: req.query.collection,
          blockHash: file.path,
        };
        console.log("Line 36 : " + file.path);

        dbo.collection("snapshots").insertOne(myobj, function (err, res) {
          if (err) throw err;
          console.log("Log : 1 document inserted ");
        });
        db.close();
        res.json({ status: "Snapshot Taken" });
      });
  });
};
