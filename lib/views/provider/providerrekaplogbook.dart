import 'dart:convert';

import 'package:attedancekaryawanump/views/model/modellogbook.dart';
import 'package:attedancekaryawanump/views/utils/version.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProviderRekapLogbook with ChangeNotifier {
  ModelRekapLogbook? data;
  SharedPreferences? sharedPreferences;
  bool? loading;
  String version = Version().version;

  getRekapLogbook(String? tahun, String? bulan) async {
    sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences?.getString('token');
    // print(tahun);
    // print(bulan);
    if (bulan == "1") {
      bulan = "01";
    } else if (bulan == "2") {
      bulan = "02";
    } else if (bulan == "3") {
      bulan = "03";
    } else if (bulan == "4") {
      bulan = "04";
    } else if (bulan == "5") {
      bulan = "05";
    } else if (bulan == "6") {
      bulan = "06";
    } else if (bulan == "7") {
      bulan = "07";
    } else if (bulan == "8") {
      bulan = "08";
    } else if (bulan == "9") {
      bulan = "09";
    }
    notifyListeners();
    //var url = Uri.parse('https://attendance.ump.ac.id/api/v1/log/history?month=${tahun}-${bulan}');
    var url = Uri.parse(
        'https://192.168.14.213:8001/api/v1/log/history?month=${tahun}-${bulan}');

    var bodyResult = await http.get(
      url,
      headers: <String, String>{
        'Accept': 'application/json',
        'User-Agent': 'neoPresensiAndroid',
        'X-Authorization': token!,
        'version': version
      },
    );
    notifyListeners();
    var dataDecode = jsonDecode(bodyResult.body);
    print("hasil logbook = ${dataDecode}");
    bool status = dataDecode["status"];
    if (status == true) {
      data = ModelRekapLogbook.fromJson(dataDecode);
      loading = true;
      notifyListeners();
    } else {
      loading = false;
      notifyListeners();
    }
  }
}
