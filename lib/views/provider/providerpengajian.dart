import 'dart:convert';

import 'package:attedancekaryawanump/views/model/modeldropdownpengajian.dart';
import 'package:attedancekaryawanump/views/model/modelpengajian.dart';
import 'package:attedancekaryawanump/views/model/modelrekap.dart';
import 'package:attedancekaryawanump/views/model/modelrekappengajian.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProviderPengajian extends ChangeNotifier {
  bool? loading;
  bool? isLoading;
  ModelPengajianGet? dataPengajian;
  List<ResponsePengajian>? listPengajian;
  List<ResponsePengajian>? listNamaKegiatan;
  ModelRekapPengajian? dataRekapPengajian;
  ModelDropdownPengajian? dataModelDropdown;
  ModelRekap? dataModelRekap;

  List<DataRes>? listdropdownpengajian;
  List<DataPengajianA>? listrekappengajian;
  bool? status;
  String? message;
  bool? statusdropdown;
  bool? statusPengajian;
  String? judul;
  String? hikmah;
  bool? loadinghit = false;

  getPengajian() async {
    var urlJadwal =
        Uri.parse('https://summarydata.ump.ac.id/lppi/api/data_pengajian');

    final prefs = await SharedPreferences.getInstance();
    var getdatabody = await http.get(
      urlJadwal,
    );
    Map<String, dynamic> jsondecode = jsonDecode(getdatabody.body);
    bool status = jsondecode['status'];
    dataPengajian = ModelPengajianGet.fromJson(jsondecode);
    print('statuslis = ${status}');
    listPengajian = [];

    notifyListeners();
    if (status == true) {
      for (var i = 0; i < dataPengajian!.data!.length; i++) {
        listPengajian!.add(ResponsePengajian(
          id: dataPengajian?.data![i].id,
          temaPengajian: dataPengajian?.data![i].temaPengajian,
          tglHijriyah: dataPengajian?.data![i].tglHijriyah,
          tglMasehi: dataPengajian?.data![i].tglMasehi,
          jamMulai: dataPengajian?.data![i].jamMulai,
          brosur: dataPengajian?.data![i].brosur,
          jamTutup: dataPengajian?.data![i].jamTutup,
          longlitude: dataPengajian?.data![i].longlitude,
          latitude: dataPengajian?.data![i].latitude,
          radius: dataPengajian?.data![i].radius,
          tempat: dataPengajian?.data![i].temaPengajian,
        ));
      }
      loading = false;
      print(listPengajian);
      notifyListeners();
    } else {
      loading = true;
      print(listPengajian);
      notifyListeners();
    }
    notifyListeners();
  }

  getnamPengajian() async {
    var urlJadwal =
        Uri.parse('https://summarydata.ump.ac.id/lppi/api/data_pengajian');

    Map getToken = {
      "username": "pangkalandata",
      "password": "ump",
    };
    final prefs = await SharedPreferences.getInstance();

    notifyListeners();

    var getdatabody = await http.get(
      urlJadwal,
    );
    Map<String, dynamic> jsondecode = jsonDecode(getdatabody.body);
    bool status = jsondecode['status'];
    dataPengajian = ModelPengajianGet.fromJson(jsondecode);
    print('statuslis = ${status}');
    listNamaKegiatan = [];
    notifyListeners();
    if (status == true) {
      for (var i = 0; i < dataPengajian!.data!.length; i++) {
        listNamaKegiatan!.add(ResponsePengajian(
          id: dataPengajian?.data![i].id,
          temaPengajian: dataPengajian?.data![i].temaPengajian,
          tglHijriyah: dataPengajian?.data![i].tglHijriyah,
          tglMasehi: dataPengajian?.data![i].tglMasehi,
          jamMulai: dataPengajian?.data![i].jamMulai,
          brosur: dataPengajian?.data![i].brosur,
          jamTutup: dataPengajian?.data![i].jamTutup,
          longlitude: dataPengajian?.data![i].longlitude,
          latitude: dataPengajian?.data![i].latitude,
          radius: dataPengajian?.data![i].radius,
          tempat: dataPengajian?.data![i].tempat,
        ));
        ;
      }
      loading = false;
      notifyListeners();
      print(listPengajian);
    } else {
      loading = true;
      print(listPengajian);
      notifyListeners();
    }
    notifyListeners();
  }

  kirimPengajian(String id, String hikmah) async {
    final prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('usernameLogin');

    print(username);
    print(id);
    print(hikmah);
    var urlJadwal =
        Uri.parse('https://summarydata.ump.ac.id/lppi/api/data_pengajian');

    Map data = {
      "nik": username,
      "id": id,
      "hikmah": hikmah,
    };
    notifyListeners();

    var getdatabody = await http.post(urlJadwal, body: data);
    Map<String, dynamic> jsondecode = jsonDecode(getdatabody.body);
    print('statuslis = ${jsondecode}');
    status = jsondecode['status'];
    message = jsondecode['message'];
    isLoading = false;
    print(jsondecode);
    notifyListeners();
  }

  dropdownPengajian() async {
    // final prefs = await SharedPreferences.getInstance();
    // String? username = prefs.getString('usernameLogin');
    // print(username);
    var urlJadwal =
        Uri.parse('https://summarydata.ump.ac.id/lppi/api/daftar_bulan');

    notifyListeners();
    var getdatabody = await http.get(urlJadwal);
    Map<String, dynamic> jsondecode = jsonDecode(getdatabody.body);
    dataModelDropdown = ModelDropdownPengajian.fromJson(jsondecode);
    listdropdownpengajian = [];
    bool? statusa = dataModelDropdown?.status;
    notifyListeners();
    if (statusa == true) {
      for (var i = 0; i < dataModelDropdown!.data!.length; i++) {
        listdropdownpengajian!.add(DataRes(
          bulan: dataModelDropdown?.data?[i].bulan,
          bln: dataModelDropdown?.data?[i].bln,
          th: dataModelDropdown?.data?[i].th,
        ));
        // rekapPengajian(
        //   dataModelDropdown?.data?[i].bln,
        //   dataModelDropdown?.data?[i].th,
        // );
      }
      statusdropdown = false;
      notifyListeners();
    } else {
      statusdropdown = true;
      notifyListeners();
    }
    notifyListeners();
    notifyListeners();
  }

  rekapPengajian(String? bulan, String? tahun, bool? loadinghita) async {
    loadinghit = loadinghita;
    final prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('usernameLogin');
    print(username);
    var urlJadwal = Uri.parse(
        'https://summarydata.ump.ac.id/lppi/api/daftar_hadir_pengajian/$bulan/$tahun/$username');

    notifyListeners();
    var getdatabody = await http.get(urlJadwal);
    Map<String, dynamic> jsondecode = jsonDecode(getdatabody.body);
    dataRekapPengajian = ModelRekapPengajian.fromJson(jsondecode);
    listrekappengajian = [];
    bool? statusa = dataModelDropdown?.status;
    notifyListeners();
    if (statusa == true) {
      for (var i = 0; i < dataRekapPengajian!.data!.length; i++) {
        listrekappengajian!.add(DataPengajianA(
          temaPengajian: dataRekapPengajian?.data?[i].temaPengajian,
          hikmah: dataRekapPengajian?.data?[i].hikmah,
          waktuPresensi: dataRekapPengajian?.data?[i].waktuPresensi,
          // tanggal: dataRekapPengajian?.data?[i].tanggal,
        ));
      }
      statusPengajian = false;
      loadinghit = false;

      notifyListeners();
    } else {
      statusPengajian = false;
      loadinghit = false;
      notifyListeners();
    }
    notifyListeners();
    notifyListeners();
  }
}
