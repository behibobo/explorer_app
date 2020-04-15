import 'dart:developer';

import 'package:explorer/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:explorer/widgets/notification_text.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class AuthProvider with ChangeNotifier {
  Status _status = Status.Uninitialized;
  String _token;
  NotificationText _notification;

  Status get status => _status;
  String get token => _token;
  NotificationText get notification => _notification;

  final String api = 'http://194.5.205.107:3000/app';

  initAuthProvider() async {
    String token = await getToken();
    if (token != null) {
      _token = token;
      _status = Status.Authenticated;
    } else {
      _status = Status.Unauthenticated;
    }
    notifyListeners();
  }

  Future<bool> login(String mobile) async {
    _status = Status.Authenticating;
    _notification = null;
    notifyListeners();

    final url = "$api/auth/login";

    Map<String, String> body = {
      'mobile': mobile,
    };

    final response = await http.post(
      url,
      body: body,
    );

    if (response.statusCode == 200) {
      // Map<String, dynamic> apiResponse = json.decode(response.body);
      // _status = Status.Authenticated;
      // _token = apiResponse['token'];
      // await storeUserData(apiResponse);
      notifyListeners();
      return true;
    }

    // if (response.statusCode == 401) {
    //   _status = Status.Unauthenticated;
    //   _notification = NotificationText('Invalid email or password.');
    //   notifyListeners();
    //   return false;
    // }

    _status = Status.Unauthenticated;
    _notification = NotificationText('Server error.');
    notifyListeners();
    return false;
  }

  Future<bool> activate(String mobile, String acticationCode) async {
    final url = "$api/auth/activate";

    Map<String, String> body = {
      'activation_code': acticationCode,
      'mobile': mobile,
    };

    final response = await http.post(
      url,
      body: body,
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> apiResponse = json.decode(response.body);
      _status = Status.Authenticated;
      _token = apiResponse['token'];
      await storeUserData(apiResponse);
      return true;
    }

    if (response.statusCode == 401) {
      _status = Status.Unauthenticated;
      _notification = NotificationText('Invalid code');
      notifyListeners();
      return false;
    }

    return false;
  }

  Future<bool> update(
    String fname, String lname, String dob, int gender) async {
    final url = "$api/user";

    String token = await getToken();

    Map body = {
      "first_name": fname,
      "last_name": lname,
      "gender": gender.toString(),
      "dob": dob,
    };

    final jsonBody = json.encode(body);
    log(body.toString());
    final response = await http.post(url,   headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
      },body: jsonBody,
    );

    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<User> profile() async {
    final url = "$api/user";

    String token = await getToken();

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      return new User.fromJson(responseJson);
    }
    return null;
  }

  storeUserData(apiResponse) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setString('token', apiResponse['token']);
  }

  Future<String> getToken() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    String token = storage.getString('token');
    return token;
  }

  logOut([bool tokenExpired = false]) async {
    _status = Status.Unauthenticated;
    if (tokenExpired == true) {
      _notification = NotificationText('Session expired. Please log in again.',
          type: 'info');
    }
    notifyListeners();

    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.clear();
  }
}
