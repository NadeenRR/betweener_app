import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import 'package:http/http.dart' as http;

Future<bool> updateLink(Map<String, String> body, id) async {
  // print('hereeee');
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  var user = userFromJson(prefs.getString('user')!);

  final response = await http.put(
    Uri.parse('https://www.osamapro.online/api/links/$id'),
    headers: {'Authorization': 'Bearer ${user.token}'},
    body: body,
  );

  // print(response.statusCode);

  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception('Failed to login');
  }
}
