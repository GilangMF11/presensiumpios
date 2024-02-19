import 'dart:convert';

import 'package:attedancekaryawanump/views/model/modellogin.dart';
import 'package:attedancekaryawanump/views/utils/version.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProviderLogin extends ChangeNotifier {
  ModelLogin? data;
  String? token;
  SharedPreferences? sharedPreferences;
  bool? faillogin;
  String? nama;
  int? usernameA;
  String? usernameLogin;
  String? passowrdLogin;
  bool? loading = false;
  String version = Version().version;
  providerLogin(String? username, String? password) async {
     var urllogin = Uri.parse('https://attendance.ump.ac.id/api/v1/auth/login');
    //var urllogin = Uri.parse('http://192.168.14.213:8001/api/v1/auth/login');
    // print("username ${username}");
    // print("password ${password}");

    Map datalogin = {
      "username": username,
      "password": password,
    };

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    IosDeviceInfo androidInfo = await deviceInfo.iosInfo;
    print('Running on ${androidInfo.data}');
    var aa = jsonEncode(androidInfo.data);
    print('json ${androidInfo.data}');
    notifyListeners();

    var login = await http.post(urllogin,
        headers: <String, String>{
          'Accept': 'application/json',
          'User-Agent': 'neoPresensiAndroid',
          'version': version,
          // 'X-Device-Id': androidInfo.data["identifierForVendor"]
          'X-Device-Id': aa
        },
        body: datalogin);
    // print(login.body);
    var dataBody = jsonDecode(login.body);
    Map<String, dynamic> decodeDataLogin = jsonDecode(login.body);
    faillogin = dataBody['status'];
    // print("status${faillogin}");
    // print("isi data${login.statusCode}");
    if (faillogin == false) {
      // print('gagal login');
    } else if (faillogin == true) {
      data = ModelLogin.fromJson(dataBody);
      final prefs = await SharedPreferences.getInstance();
      notifyListeners();
      loading = true;
      token = dataBody['token'];
      nama = dataBody['data']['nama'];
      prefs.setBool("status", faillogin!);
      prefs.setString("token", token!);
      prefs.setString("nama", nama!);
      prefs.setString("usernameLogin", username!);
      prefs.setString("passwordLogin", password!);
    } else {
      loading = false;
      // print('gagal login');
    }
    SharedPreferences sharedPeferences = await SharedPreferences.getInstance();
  }
}
