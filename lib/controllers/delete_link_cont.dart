import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import 'package:http/http.dart' as http;

Future<bool> deleteLink(id) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  User user = userFromJson(prefs.getString('user')!);

  final response = await http.delete(
    Uri.parse('https://www.osamapro.online/api/links/$id'),
    headers: {'Authorization': 'Bearer ${user.token}'},
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    throw Exception('Failed to login');
  }
}
