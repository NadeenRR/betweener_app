import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tt9_betweener_challenge/constants.dart';
import 'package:tt9_betweener_challenge/models/user.dart';
import 'package:tt9_betweener_challenge/views/login_view.dart';

import '../models/link.dart';
import 'package:http/http.dart' as http;

Future<List<Links>> getLinks(context) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  User user = userFromJson(prefs.getString('user')!);

  print('aaaa');
  print(user.token);
  final response = await http.get(Uri.parse(linkUrl),
      headers: {'Authorization': 'Bearer ${user.token}'});

  print(response.body);

  print('eeee');

  // print(jsonDecode(response.body)['links']);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body)['links'] as List<dynamic>;

    return data.map((e) => Links.fromJson(e)).toList();
  }

  if (response.statusCode == 401) {
    Navigator.pushReplacementNamed(context, LoginView.id);
  }
  return Future.error('Somthing wrong');
}

Future<void> addNewlink(Map<String, String> body) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  User user = userFromJson(prefs.getString('user')!);
  final response = await http.post(
    Uri.parse(linkUrl),
    body: body,
    headers: {'Authorization': 'Bearer ${user.token}'},
  );

  if (response.statusCode == 200) {
    //return linksFromJson(response.body);
  }

  return Future.error('Somthing wrong');
}
