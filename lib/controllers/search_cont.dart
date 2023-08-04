import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tt9_betweener_challenge/constants.dart';
import 'package:tt9_betweener_challenge/models/search.dart';

Future<Search> searchUsersByName(Map body) async {
  final response = await http.post(
    Uri.parse(searchUrl),
    body: body,
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    return Search.fromJson(data);
  } else {
    print(response.statusCode);
    throw Exception('Failed to load users');
  }
}
