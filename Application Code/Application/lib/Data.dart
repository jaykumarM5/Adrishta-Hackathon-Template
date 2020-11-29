import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

String email = '';
String otp;

String otpUrl =
    'https://i-voted.vercel.app/api/v1/setotp/rishabh12536@gmail.com';

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
