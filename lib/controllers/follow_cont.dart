import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tt9_betweener_challenge/constants.dart';
import 'package:tt9_betweener_challenge/models/follow.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';
import '../views/login_view.dart';

Future<Follow> getFollow(context) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  User user = userFromJson(prefs.getString('user')!);

  final response = await http.get(Uri.parse(followUrl),
      headers: {'Authorization': 'Bearer ${user.token}'});

  //print('${response.statusCode} ');
  if (response.statusCode == 200) {
    final data = followFromJson(response.body);

    return data;
  }

  if (response.statusCode == 401) {
    Navigator.pushReplacementNamed(context, LoginView.id);
  }

  return Future.error('Somthing wrong');
}

Future<void> addFollower(Map body) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  User user = userFromJson(prefs.getString('user')!);

  final response = await http.post(Uri.parse(followUrl),
      body: body, headers: {'Authorization': 'Bearer ${user.token}'});

  if (response.statusCode == 200) {
    //print('${response.statusCode} ');
  }

  return Future.error('Somthing wrong');
}
