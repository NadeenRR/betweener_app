import 'package:http/http.dart' as http;
import 'package:tt9_betweener_challenge/constants.dart';
import '../models/user.dart';

Future<User> login(Map body) async {
  final response = await http.post(
    Uri.parse(loginUrl),
    body: body,
  );
  if (response.statusCode == 200) {
    return userFromJson(response.body);
  } else {
    throw Exception('Error in login');
  }
}

Future<User> register(Map body) async {
  final response = await http.post(
    Uri.parse(registerUel),
    body: body,
  );
  if (response.statusCode == 201) {
    return userFromJson(response.body);
  } else {
    throw Exception('Error in register');
  }
}
