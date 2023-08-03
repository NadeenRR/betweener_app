import 'package:shared_preferences/shared_preferences.dart';
import 'package:tt9_betweener_challenge/models/user.dart';

Future<User> getLocalUser() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('user')) {
    return userFromJson(prefs.getString('user')!);
  }
  return Future.error('User not found');
}
