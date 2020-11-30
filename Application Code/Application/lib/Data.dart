import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

String email = '';
String otp = '1';

String jayInsta = 'https://instagram.com/little.j.hobbit?igshid=14np6usrilpyp';
String jayLinkedIn = 'https://linkedin.com/in/jay-kumar-smit';
String surajInsta =
    'https://instagram.com/surajkumarojha9123?igshid=eg6o81e2v0pf';
String surajLinkedIn = 'https://www.linkedin.com/in/suraj-kumar-ojha-b51511194';

String rishabhInsta = 'https://www.instagram.com/rishabh.live/';
String rishabhLinkedIn = 'https://www.linkedin.com/in/rishabh0508/';

String otpUrl =
    'https://i-voted.vercel.app/api/v1/setotp/rishabh12536@gmail.com';

String tempEmail = '';

Future login() async {
  try {
    var response = await http.get(otpUrl + email);
    print(response.body);
    var data = json.decode(response.body);
    otp = data["otp"].toString();
    print(otp);
  } catch (e) {
    print(e);
  }
}
