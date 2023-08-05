import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../models/link.dart';
import '../models/user.dart';

Future<List<Links>> editProfilee() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  User user = userFromJson(prefs.getString('user')!);

  final response = await http.get(Uri.parse(linkUrl),
      headers: {'Authorization': 'Bearer ${user.token}'});

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  }

  return Future.error('Somthing wrong');
}
