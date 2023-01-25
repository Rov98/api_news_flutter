import 'dart:async';

import 'package:api_news_flutter/model/httpException.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String? _token;
  String? _id;
  DateTime? _expiredTokenDate;
  Timer? _authTimer;

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_token != null &&
        _expiredTokenDate!.isAfter(DateTime.now()) &&
        _expiredTokenDate != null) {
      return _token;
    }
    return null;
  }

  Future<void> _authentication(
      String email, String password, String authWeb) async {
    var url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$authWeb?key=AIzaSyDHH2mfgUmIIGk68EwfJBbPd_1M9a_VDDQ');
    //wrap the login and register method with try
    try {
      final response = await http.post(url,
          body: json.encode({
            'email': email.trimRight(),
            'password': password,
            'returnSecureToken': true,
          }));
      //use httpException for sending error messages
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      if (authWeb == 'signUp') {
        //stop at signup
      } else {
      //set Token and expiredDate (important)
      _token = responseData['idToken'];
      _id = responseData['localId'];
      _expiredTokenDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      //call autoLogut after the authentication begins
      // autoLogout();
      notifyListeners(); // IMPORTANT IMPORTANT IMPORTANT
      //Shared Preferences for user token to login automatically
      final pref = await SharedPreferences.getInstance();
      final prefData = jsonEncode({
        'token': _token,
        'id': _id,
        'expireDate': _expiredTokenDate!.toIso8601String(),
      });
      pref.setString('prefData', prefData);
      }
    } catch (e) {
      throw e;
    }
  }

  Future<void> login(String email, String password) async {
    return _authentication(email, password, 'signInWithPassword');
  }

  Future<void> signUp(String email, String password) async {
    return _authentication(email, password, 'signUp');
  }

  Future<bool> autoLogin() async {
    final pref = await SharedPreferences.getInstance();
    if (!pref.containsKey('prefData')) {
      return false;
    }
    final extractedPrefData =
        json.decode(pref.getString('prefData')!) as Map<String, dynamic>;
    // i extracted the expiredate first to check if the expiredate is before now. if true which is already expired
    final expireDate =
        DateTime.parse(extractedPrefData['expireDate'].toString());
    //check if expired
    if (expireDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedPrefData['token'].toString();
    _id = extractedPrefData['id'].toString();
    _expiredTokenDate = expireDate;
    //use notifylisteners first and then logout. because notify the data change and then logout
    notifyListeners();
    autoLogout();
    return true;
  }

  void logOut() async {
    //clear all user data
    _token = null;
    _id = null;
    _expiredTokenDate = null;
    notifyListeners();
    //clear preferences data
    final pref = await SharedPreferences.getInstance();
    // pref.remove('prefData'); use this if there's other data in the preferences data
    pref.clear();
  }

  void autoLogout() {
    if (_authTimer != null) {
      _authTimer?.cancel();
    }
    final _timeToExpired =
        _expiredTokenDate!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(
        Duration(seconds: _timeToExpired),
        //calling logout
        logOut);
  }
}
