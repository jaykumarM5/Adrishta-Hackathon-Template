// Stroes all the urls and data fetch functions

import 'package:http/http.dart' as http;
import 'dart:convert';

String email = '';
String otp = '1';
String role = '';
String bio = '';
String candidateName = '';

String candidateAddUrl =
    'https://i-voted.vercel.app/api/v1/blockchain/addCandidate/';

String candidateRMUrl =
    'https://i-voted.vercel.app/api/v1/blockchain/removeCandidate/';

String voterBanUrl = 'https://i-voted.vercel.app/api/v1/blockchain/';

String voterRevokeUrl = 'https://i-voted.vercel.app/api/v1/blockchain/';

String otpUrl = 'https://i-voted.vercel.app/api/v1/setotp/';

String eventsUrl = 'https://i-voted.vercel.app/api/v1/blockchain/events/list';

String eventAddUrl = 'https://i-voted.vercel.app/api/v1/blockchain/events/add';

String candidateListUrl =
    'https://i-voted.vercel.app/api/v1/blockchain/listCandidate/';

String voteUrl1 = 'https://i-voted.vercel.app/api/v1/blockchain/voteHIstory/';

String voteUrl2 = 'https://i-voted.vercel.app/api/v1/blockchain/voteHIstory/';

String checkVoterUrl = 'https://i-voted.vercel.app/api/v1/blockchain/';

String addVoterUrl = 'https://i-voted.vercel.app/api/v1/blockchain/';

String jayInsta = 'https://instagram.com/little.j.hobbit?igshid=14np6usrilpyp';
String jayLinkedIn = 'https://linkedin.com/in/jay-kumar-smit';
String surajInsta =
    'https://instagram.com/surajkumarojha9123?igshid=eg6o81e2v0pf';
String surajLinkedIn = 'https://www.linkedin.com/in/suraj-kumar-ojha-b51511194';

String rishabhInsta = 'https://www.instagram.com/rishabh.live/';
String rishabhLinkedIn = 'https://www.linkedin.com/in/rishabh0508/';

String tempEmail = '';

void login() async {
  try {
    var response = await http.get(otpUrl + email + '@smit.smu.edu.in');
    var data = json.decode(response.body);
    otp = data["otp"].toString();
    role = data["role"];
    print(otp);
    print(role);
  } catch (e) {
    print(e);
  }
}

Future addCandidate(id) async {
  try {
    var response = await http.post(candidateAddUrl + tempEmail,
        body: jsonEncode({"bio": bio, "name": candidateName, 'eventid': id}));
    var data = json.decode(response.body);
    print(data["status"]);
  } catch (e) {
    print(e);
  }
  return;
}

Future removeCandidate(id) async {
  try {
    var response = await http.get(candidateRMUrl + '$id/' + tempEmail);
    var data = json.decode(response.body);
    print(data["status"]);
  } catch (e) {
    print(e);
  }
  return;
}

Future banVoter() async {
  try {
    var response = await http.get(voterBanUrl + tempEmail + '/ban');
    var data = json.decode(response.body);
    print(data["status"]);
  } catch (e) {
    print(e);
  }
  return;
}

Future revokeBanVoter() async {
  try {
    var response = await http.get(voterRevokeUrl + tempEmail + '/revokeban');
    var data = json.decode(response.body);
    print(data["status"]);
  } catch (e) {
    print(e);
  }
  return;
}

Future addElection(name, from, to) async {
  try {
    var response = await http.post(eventAddUrl,
        body: jsonEncode({"name": name, 'from': from, "to": to}));
    var data = json.decode(response.body);
    print(data["status"]);
  } catch (e) {
    print(e);
  }
  return;
}

Future vote(voter, candidate) async {
  try {
    var response = await http.get(voteUrl1 + voter + '/' + candidate);
    var response1 = await http.get(voteUrl2 + voter + '/' + candidate);
    var data = json.decode(response.body);
    print(data["status"]);
  } catch (e) {
    print(e);
  }
  return;
}

Future<bool> checkVote() async {
  try {
    var response = await http.get(checkVoterUrl + email + '/check');
    var data = json.decode(response.body);
    var response1 =
        await http.get('https://gateway.ipfs.io/ipfs/' + data["lastBlock"]);
    var data1 = json.decode(response1.body);
    if (data1["vr"] == "alright") {
      return true;
    } else {
      print("inside else");
      return false;
    }
  } catch (e) {
    print(e);
  }
  return true;
}

Future addVoter() async {
  try {
    var response = await http.get(addVoterUrl + email + '/alright');
    var data = json.decode(response.body);
    print(data["status"]);
  } catch (e) {
    print(e);
  }
  return;
}
