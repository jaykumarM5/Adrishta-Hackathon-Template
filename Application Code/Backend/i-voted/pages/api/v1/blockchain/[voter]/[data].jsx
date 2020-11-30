const IpfsHttpClient = require("ipfs-http-client");
const MongoClient = require("mongodb").MongoClient;
var url = process.env.MONGO_SERVER;

export default async function main(req, res) {
  const { globSource } = IpfsHttpClient;
  const ipfs = IpfsHttpClient({
    timeout: 10000,
    host: "ipfs.infura.io",
    port: "5001",
    protocol: "https",
  });
  var file;

  MongoClient.connect(url, function (err, db) {
    if (err) throw err;
    var dbo = db.db("iVoted");
    //check if ban request

    if (req.query.data == "ban") {
      dbo.collection("banVoter").createIndex({ voterid: 1 }, { unique: true });

      var myobj = {
        voterid: req.query.voter,
      };
      dbo.collection("banVoter").insertOne(myobj, function (err, res) {
        if (err) throw err;
        console.log("Log : 1 document inserted ");
      });
    } else if (req.query.data == "alright") {
      // Check if exist
      dbo
        .collection("voters")
        .find({ user: req.query.voter })
        .toArray(async function (err, result) {
          if (err) throw err;
          console.log(result);
          var lb = "X";
          console.log(lb);
          if (result.length == 0) {
            var cntnt =
              "{ name :" +
              req.query.voter +
              '", date : "' +
              new Date() +
              '", pb : "X", vr :"' +
              req.query.data +
              '" }';
            file = await ipfs.add(cntnt);
            console.log("Log : Uploaded to IPFS > " + cntnt);
            var myobj = { user: req.query.voter, lb: file.path };
            dbo.collection("voters").insertOne(myobj, function (err, res) {
              if (err) throw err;
              console.log("Log : 1 document inserted ");
            });
            res.json({ vrid: file.path });
          } else {
            lb = result[0].lb;
            var cntnt =
              "{ name :" +
              req.query.voter +
              '", date : "' +
              new Date() +
              '", pb : "' +
              lb +
              '", vr :"' +
              req.query.data +
              '" }';
            file = await ipfs.add(cntnt);
            var myobj = { $set: { user: req.query.voter, lb: file.path } };
            var myquery = { user: req.query.voter };
            console.log("Log : available");
            dbo
              .collection("voters")
              .updateOne(myquery, myobj, function (err, res) {
                if (err) throw err;
                console.log("1 document updated");
                db.close();
              });
            res.json({ vrid: file.path });
          }
          db.close();
        });
    } else {
      res.json({status : 400});
    }
  });
}

async function AddToIPFS(cntnt) {
  var Qmhash = await ipfs.add(cntnt);

  return Qmhash;
}
