import 'package:http/http.dart' as http;
import 'package:tt9_betweener_challenge/constants.dart';
import 'package:tt9_betweener_challenge/models/register.dart';
import '../models/user.dart' as user;

Future<user.User> login(Map body) async {
  final response = await http.post(
    Uri.parse(loginUrl),
    body: body,
  );
  if (response.statusCode == 200) {
    return user.userFromJson(response.body);
  } else {
    throw Exception('Error in login');
  }
}

Future<Register> register(Map body) async {
  final response = await http.post(
    Uri.parse(registerUel),
    body: body,
  );
  print('ddd');
  if (response.statusCode == 200) {
    print('regsiter');
    return registerFromJson(response.body);
  } else {
    throw Exception('Error in register');
  }
}
