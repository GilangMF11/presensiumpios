import 'dart:convert';

import 'package:attedancekaryawanump/views/model/modellokasi.dart';
import 'package:attedancekaryawanump/views/utils/version.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/locationAA.dart';

class ProviderPresensi extends ChangeNotifier {
  SharedPreferences? sharedPreferences;
  var dataA;
  ModelLocation? datalokasi;
  bool? loading;
  // List<DetailAA> dataLocationA = [];
  List<DataISI> nameLokasi = [];
  getLocation() async {
    try {
      String version = Version().version;
      sharedPreferences = await SharedPreferences.getInstance();
      String? token = sharedPreferences?.getString('token');
      var url = Uri.parse("http://192.168.14.213:8001/api/v1/data/location");
      Map<String, String> head = {
        'Accept': 'application/json',
        'User-Agent': 'neoPresensiAndroid',
        'X-Authorization': token ?? "",
        'version': version
      };
      nameLokasi = [];
      var dataPost = await http.get(url, headers: head);
      var datadecode = jsonDecode(dataPost.body);
      // print("status ${datadecode}");
      // final Map<String, dynamic> datadecode = json.decode(dataPost.body);
      if (datadecode['status'] == true) {
        loading = false;
        print("asasalksm");
        datalokasi = ModelLocation.fromJson(datadecode);
        print("status ${datadecode['detail']}");
        for (var i = 0; i < datalokasi!.data!.length; i++) {
          nameLokasi.add(DataISI(
              label: datalokasi!.data![i].label ?? "",
              detail: DetailAA(
                  lat: datalokasi!.data![i].detail?.lat,
                  long: datalokasi!.data![i].detail?.long,
                  radius: datalokasi!.data![i].detail!.radius,
                  idlokasi: "${i + 1}")));

          // dataLocationA.add(
          //   DetailAA(
          //     long: datalokasi!.data![i].detail?.long,
          //     lat: datalokasi!.data![i].detail?.lat,
          //   ),
          // );
          print("asdasd");
          print("pqwiqwuiqwu");
        }

        //      final List<Location> locations = [
        //   Location(name: "Kampus Pusat", latitude: -7.413241, longitude: 109.272966),
        //   Location(name: "Fikes", latitude: -7.449878, longitude: 109.2793776),
        //   Location(name: "RSDC", latitude: -7.4078243, longitude: 109.2783913),
        //   // Add more locations here
        // ];

        // for (var data in datadecode) {
        //   dataLocationA.add(
        //     LocationAL(
        //       name: data['name'],
        //       coordinates: List<double>.from(data['coordinates']),
        //     ),
        //   );
        //   print(data['name']);
        //   print(data['coordinates']);
        // }
        // dataLok?.add(Location(
        //   name: datadecode['data'][i],
        //   longitude: datadecode['data'][i][0],
        //   latitude: datadecode['data'][i][1],
        // asrama: datalokasi?.data?.asrama,
        // fikes: datalokasi?.data?.fikes,
        // kampusPusat: datalokasi?.data?.kampusPusat,
        // klinikTriSalimah: datalokasi?.data?.klinikTriSalimah,
        // labFAPERTA: datalokasi?.data?.labFAPERTA,
        // pDABanyumas: datalokasi?.data?.pDABanyumas,
        // pKUGombong: datalokasi?.data?.pKUGombong,
        // pSDKUMP: datalokasi?.data?.pSDKUMP,
        // rSDC: datalokasi?.data?.rSDC,
        // pDMBanyumas: datalokasi?.data?.pDMBanyumas,
        // rSIPurwokerto: datalokasi?.data?.rSIPurwokerto,
        // rSUDDrSoeseloSlawi: datalokasi?.data?.rSUDDrSoeseloSlawi,
        // rSUDSalatiga: datalokasi?.data?.rSUDSalatiga,
        // sDUMP: datalokasi?.data?.sDUMP,
        // sMPUMP: datalokasi?.data?.sMPUMP,
        // ));
        // print(dataLok![i]);
        // }
        // print(dataLok);

        // transformedJson = transformJson(datadecode);
        // print(transformedJson);
        notifyListeners();
      } else {}
    } catch (e) {
      loading = false;
    }
  }

  providerPresensi(String? flag, String? version, String? idlokasi) async {
    // int idStringtoInt = int.parse(idlokasi ?? "");
    print(idlokasi);

    var url = Uri.parse('https://attendance.ump.ac.id/api/v1/attendance');
    sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences?.getString('token');
    Map data = {'flag': flag, 'id_lokasi': idlokasi};
    Map<String, String> head = {
      'Accept': 'application/json',
      'User-Agent': 'neoPresensiAndroid',
      'X-Authorization': token ?? "",
      'version': version ?? ""
    };
    var dataPost = await http.post(url, headers: head, body: data);
    notifyListeners();
    dataA = jsonDecode(dataPost.body);
    print("hasil ${dataA}");
    notifyListeners();
  }
}
