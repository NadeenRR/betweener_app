import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tt9_betweener_challenge/constants.dart';
import 'package:tt9_betweener_challenge/models/search.dart';

import '../models/user.dart' as userModel;

Future<Search> searchUsersByName(Map body) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  userModel.User user = userModel.userFromJson(prefs.getString('user')!);
  try {
    final response = await http.post(
      Uri.parse('http://www.osamapro.online/api/search'),
      body: body,
      headers: {'Authorization': 'Bearer ${user.token}'},
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return Search.fromJson(data);
    } else {
      print('Search failed with status code: ${response.statusCode}');
      throw Exception('Failed to load users: ${response.body}');
    }
  } catch (e) {
    print('Error during user search: $e');
    throw Exception('Failed to perform user search.');
  }
}
