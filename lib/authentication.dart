import 'dart:convert';
import 'dart:io';

import 'package:cryptography/cryptography.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Authentication {
  static SharedPreferences? _storage;
  static Future? _init;
  static String? _username;
  static String? _token;

  static Future<String?> getToken() async {
    await _init ?? NullThrownError();
    return _token;
  } 
  
  static Future<String?> getUsername() async {
    await _init ?? NullThrownError();
    return _username;
  } 

  static void init() {
    _init = _initialize();
  }

  static Future _initialize() async {
    _storage = await SharedPreferences.getInstance();
    await setUser(_storage!.getString('token'));
  }

  static Future setUser(String? token) async {
    if (token != null) {
      final response = await http.get(
        Uri.parse('https://localhost:7045/user/getuser'), 
        headers: {
          'Authorization':'bearer $token'
        }
      );
      if (response.statusCode == 200) {
        _username = response.body;
        _token = token;
        print('hi $_username');
      } else {
        _username = _token = null;
      }
    } 
    _storage!.setString('token', _token ?? '');
  }

  static Future<List<int>> hashAndSalt({required List<int> salt, required String password}) async {
    final pbkdf2 = Pbkdf2(
      macAlgorithm: Hmac.sha256(),
      iterations: 2048,
      bits: 384,
    );
    final saltedPwrd = await pbkdf2.deriveKey(
      secretKey: SecretKey(utf8.encode(password)),
      nonce: salt,
    );
    return saltedPwrd.extractBytes();
  }
}