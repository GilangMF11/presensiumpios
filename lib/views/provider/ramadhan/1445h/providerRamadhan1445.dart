import 'dart:convert';

import 'package:attedancekaryawanump/views/model/modelGetGelombang.dart';
import 'package:attedancekaryawanump/views/model/modelalquransurah.dart';
import 'package:attedancekaryawanump/views/model/modeldoa.dart';
import 'package:attedancekaryawanump/views/model/modelevaluasi.dart';
import 'package:attedancekaryawanump/views/model/modelevaluasiquisioner.dart';
import 'package:attedancekaryawanump/views/model/modelimsyakiyah.dart';
import 'package:attedancekaryawanump/views/model/modelpresensiramadhan.dart';
import 'package:attedancekaryawanump/views/model/modelpretest.dart';
import 'package:attedancekaryawanump/views/model/modelrekappresensiramadhan.dart';
import 'package:attedancekaryawanump/views/model/modelsoalerror.dart';
import 'package:attedancekaryawanump/views/model/modelsurah.dart';
import 'package:attedancekaryawanump/views/model/modelsurahakhir.dart';
import 'package:attedancekaryawanump/views/model/modelsurahawal.dart';
import 'package:attedancekaryawanump/views/provider/ramadhan/1445h/model/logbookModel1445.dart';
import 'package:attedancekaryawanump/views/utils/version.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'model/kegiatanModel1445.dart';

class ProviderRamadhan1445 with ChangeNotifier {
  ModelSurahAwal? dataAwal;
  ModelSurahAkhir? dataAkhir;
  ModelGetGelombang? datagelombang;
  ModelSurah? data;
  ModelAlQuranSurah? dataSurah;
  ModelImsyakyah? dataimsyakya;
  ModelPresensiRamadhan? datapresensiRamdhadan;
  ModelDoa? dataDoa;
  ModelEvaluasi? modalEvaluasi;
  ModelPretest? datapretest;
  ModelPretest? datapostest;
  ModelEvaluasiQuisioner? dataquisioner;
  ModelSoalError? dataErrorPretest;
  ModelRekapPresensiRamdhan? rekappresensiramadhan;
  ModelLogbook1445? dataLogbook;
  SharedPreferences? sharedPreferences;
  String? statusgel;
  String? statuspretest;
  String? statuspostest;
  String? statusquisioner;
  bool? loading;
  bool? loadingsurah;
  bool? loadingimsyakiyah;
  bool? loadingMenu;
  bool? loadingcekstatuseval;
  bool? laodingkirimeval;
  bool? laodinghapusval;
  bool? loadingSoalPretest;
  bool? loadingSoalPostest;
  bool? loadingquisioner;
  bool? kirimSoalPretest;
  bool? kirimSoalPostest;
  bool? kirimquisioner;
  bool? loadinggetpengajian;
  bool? loadingkirimpresensi;
  bool? loadingdoa;
  bool? rekaploadingramadhan;
  bool? loadingsertifikat;
  bool? loadingLogbookRamadhan;
  String? gelombang;
  String? statuPresensiDibuka;
  String? statuPresensiKet;
  String version = Version().version;
  String? statusData;
  String? statusevaluasi;
  String? kritik;
  String? saran;
  String? statuskirimEval;
  String? statushapusEval;
  String? skor = "";
  String? presensistatus;
  String? link;
  String? statussertifikat;
  // List<int>? soaljawbanid = [];
  // List<String>? soaljawbantext = [];

  getAlQuran(int? surah) async {
    sharedPreferences = await SharedPreferences.getInstance();
    print(surah);
    var url = Uri.parse('https://equran.id/api/v2/surat/$surah');
    var bodyResult = await http.get(
      url,
      headers: <String, String>{
        'Accept': 'application/json',
        'User-Agent': 'neoPresensiAndroid',
        // 'X-Authorization': token!,
        // 'version': version
      },
    );
    notifyListeners();
    var dataDecode = jsonDecode(bodyResult.body);
    int status = dataDecode["code"];
    if (status == 200) {
      if (surah == 1) {
        print("datawals");
        dataAwal = ModelSurahAwal.fromJson(dataDecode);
        statusData = "awal";
        loading = false;
        notifyListeners();
      } else if (surah == 114) {
        print("datawak");
        dataAkhir = ModelSurahAkhir.fromJson(dataDecode);
        loading = false;
        statusData = "akhir";
        notifyListeners();
      } else {
        print("data");
        data = ModelSurah.fromJson(dataDecode);
        statusData = "tengah";
        loading = false;
        notifyListeners();
      }
    } else {
      loading = true;
      notifyListeners();
    }
  }

  getAlQuranSurah() async {
    sharedPreferences = await SharedPreferences.getInstance();

    notifyListeners();
    var url = Uri.parse('https://equran.id/api/v2/surat/');
    var bodyResult = await http.get(
      url,
      headers: <String, String>{
        'Accept': 'application/json',
        'User-Agent': 'neoPresensiAndroid',
        // 'X-Authorization': token!,
        // 'version': version
      },
    );
    notifyListeners();
    var dataDecode = jsonDecode(bodyResult.body);
    int status = dataDecode["code"];
    if (status == 200) {
      dataSurah = ModelAlQuranSurah.fromJson(dataDecode);
      loadingsurah = false;
      notifyListeners();
    } else {
      loadingsurah = true;
      notifyListeners();
    }
  }

  getImsyakiyah(String? date) async {
    var urltoken = Uri.parse('https://developer.ump.ac.id/token/index.php');
    var url =
        Uri.parse('https://developer.ump.ac.id/PD/ramadhan1445/imsakiyah.php');

    Map getToken = {
      "username": "pangkalandata",
      "password": "ump",
    };
    var tokenencode = json.encode(getToken);
    var responseToken = await http.post(urltoken, body: tokenencode);
    var xtokenDecode = json.decode(responseToken.body);
    // ignore: avoid_print
    print(responseToken.body);
    var xtoken = xtokenDecode['response']['token'];
    // ignore: avoid_print
    print(xtoken);
    Map<String, String> headersxtoken = {"x-token": xtoken};
    var body = {"tgl": date};
    var bodyencode = json.encode(body);
    var bodyResult =
        await http.post(url, headers: headersxtoken, body: bodyencode);
    var dataDecode = jsonDecode(bodyResult.body);
    print(dataDecode);
    String? status = dataDecode["metaData"]["code"];
    if (status == "200") {
      dataimsyakya = ModelImsyakyah.fromJson(dataDecode);
      // dataimsyakyah?.add((dataDecode["response"]));
      loadingimsyakiyah = false;
      notifyListeners();
    } else {
      loadingimsyakiyah = false;
      notifyListeners();
    }
  }

  getMenuBaik() async {
    sharedPreferences = await SharedPreferences.getInstance();
    String? username = sharedPreferences!.getString('usernameLogin');
    var urltoken = Uri.parse('https://developer.ump.ac.id/token/index.php');
    var urllogin = Uri.parse('https://developer.ump.ac.id/PD/login.php');

    Map getToken = {
      "username": "pangkalandata",
      "password": "ump",
    };
    var tokenencode = json.encode(getToken);
    notifyListeners();
    var responseToken = await http.post(urltoken, body: tokenencode);
    var xtokenDecode = json.decode(responseToken.body);
    // ignore: avoid_print
    print(responseToken.body);
    var xtoken = xtokenDecode['response']['token'];
    // ignore: avoid_print
    print(xtoken);
    Map<String, String> headersxtoken = {"x-token": xtoken};

    var url = Uri.parse(
        'https://developer.ump.ac.id/PD/ramadhan1445/infokegiatanterdaftar.php');
    var body = {"USERNAME": "$username"};
    var bodyencode = jsonEncode(body);
    var bodyResult =
        await http.post(url, headers: headersxtoken, body: bodyencode);
    // Map<String, dynamic> decodeDataLogin = jsonDecode(bodyResult.body);
    notifyListeners();
    var dataDecode = jsonDecode(bodyResult.body);
    String status = dataDecode["metaData"]["code"];
    print(dataDecode);
    if (status == "200") {
      datagelombang = ModelGetGelombang.fromJson(dataDecode);
      statusgel = datagelombang?.response?[0].keterangan;
      gelombang = datagelombang?.response?[0].gelombangId;
      sharedPreferences?.setString(
          "gelombang", datagelombang?.response?[0].gelombangId ?? "");
      loadingMenu = false;
      notifyListeners();
    } else {
      loadingMenu = true;
      notifyListeners();
    }
  }

  cekEvaluasi() async {
    sharedPreferences = await SharedPreferences.getInstance();
    String? gelombang = sharedPreferences!.getString('gelombang');
    String? username = sharedPreferences!.getString('usernameLogin');
    var urltoken = Uri.parse('https://developer.ump.ac.id/token/index.php');
    var urllogin = Uri.parse('https://developer.ump.ac.id/PD/login.php');

    Map getToken = {
      "username": "pangkalandata",
      "password": "ump",
    };
    var tokenencode = json.encode(getToken);
    notifyListeners();
    var responseToken = await http.post(urltoken, body: tokenencode);
    var xtokenDecode = json.decode(responseToken.body);
    // ignore: avoid_print
    print(responseToken.body);
    var xtoken = xtokenDecode['response']['token'];
    // ignore: avoid_print
    print(xtoken);
    Map<String, String> headersxtoken = {"x-token": xtoken};

    var url =
        Uri.parse('https://developer.ump.ac.id/PD/ramadhan1445/evaluasi.php');
    var body = {
      "USERNAME": username,
      "gelombang_id": gelombang,
      "perintah_id": "1"
    };
    var bodyencode = jsonEncode(body);
    var bodyResult =
        await http.post(url, headers: headersxtoken, body: bodyencode);
    // Map<String, dynamic> decodeDataLogin = jsonDecode(bodyResult.body);
    notifyListeners();
    var dataDecode = jsonDecode(bodyResult.body);
    print(dataDecode);
    String status = dataDecode["metaData"]["code"];
    if (status == "200") {
      modalEvaluasi = ModelEvaluasi.fromJson(dataDecode);
      print("banyak ${modalEvaluasi?.response?.length}");
      print(gelombang);
      if (modalEvaluasi!.response!.isEmpty) {
        kritik = "";
        saran = "";
        statusevaluasi = "belum";
        loadingMenu = false;
        notifyListeners();
      } else {
        kritik = modalEvaluasi?.response?[0].kritik;
        saran = modalEvaluasi?.response?[0].saran;
        statusevaluasi = "sudah";
        loadingMenu = false;
        notifyListeners();
      }
    } else if (status == "404") {
      kritik = "";
      saran = "";
      statusevaluasi = "belum";
      loadingMenu = true;
      notifyListeners();
    }
  }

  kirimEvaluasi(String? kiritkA, String? saranA) async {
    sharedPreferences = await SharedPreferences.getInstance();
    String? gelombang = sharedPreferences!.getString('gelombang');
    String? username = sharedPreferences!.getString('usernameLogin');
    var urltoken = Uri.parse('https://developer.ump.ac.id/token/index.php');
    var urllogin = Uri.parse('https://developer.ump.ac.id/PD/login.php');

    Map getToken = {
      "username": "pangkalandata",
      "password": "ump",
    };
    var tokenencode = json.encode(getToken);
    notifyListeners();
    var responseToken = await http.post(urltoken, body: tokenencode);
    var xtokenDecode = json.decode(responseToken.body);
    // ignore: avoid_print
    print(responseToken.body);
    var xtoken = xtokenDecode['response']['token'];
    // ignore: avoid_print
    print(xtoken);
    Map<String, String> headersxtoken = {"x-token": xtoken};

    var url =
        Uri.parse('https://developer.ump.ac.id/PD/ramadhan1445/evaluasi.php');
    var body = {
      "USERNAME": username,
      "gelombang_id": gelombang,
      "perintah_id": "2",
      "kritik": kiritkA,
      "saran": saranA
    };
    var bodyencode = jsonEncode(body);
    var bodyResult =
        await http.post(url, headers: headersxtoken, body: bodyencode);
    // Map<String, dynamic> decodeDataLogin = jsonDecode(bodyResult.body);
    notifyListeners();
    var dataDecode = jsonDecode(bodyResult.body);
    print(dataDecode);
    String status = dataDecode["ket"];
    print(status);
    if (status == "berhasil tambah data") {
      statuskirimEval = "berhasil";
      laodingkirimeval = false;
      notifyListeners();
    } else if (status == "berhasil update data") {
      statuskirimEval = "berhasil";
      laodingkirimeval = false;
      notifyListeners();
    } else {
      statuskirimEval = "gagal";
      laodingkirimeval = false;

      notifyListeners();
    }
  }

  hapusEvaluasi() async {
    sharedPreferences = await SharedPreferences.getInstance();
    String? gelombang = sharedPreferences!.getString('gelombang');
    String? username = sharedPreferences!.getString('usernameLogin');
    var urltoken = Uri.parse('https://developer.ump.ac.id/token/index.php');
    var urllogin = Uri.parse('https://developer.ump.ac.id/PD/login.php');

    Map getToken = {
      "username": "pangkalandata",
      "password": "ump",
    };
    var tokenencode = json.encode(getToken);
    notifyListeners();
    var responseToken = await http.post(urltoken, body: tokenencode);
    var xtokenDecode = json.decode(responseToken.body);
    // ignore: avoid_print
    print(responseToken.body);
    var xtoken = xtokenDecode['response']['token'];
    // ignore: avoid_print
    print(xtoken);
    Map<String, String> headersxtoken = {"x-token": xtoken};

    var url =
        Uri.parse('https://developer.ump.ac.id/PD/ramadhan1445/evaluasi.php');
    var body = {
      "USERNAME": username,
      "gelombang_id": gelombang,
      "perintah_id": "3",
    };
    var bodyencode = jsonEncode(body);
    var bodyResult =
        await http.post(url, headers: headersxtoken, body: bodyencode);
    // Map<String, dynamic> decodeDataLogin = jsonDecode(bodyResult.body);
    notifyListeners();
    var dataDecode = jsonDecode(bodyResult.body);
    String status = dataDecode["ket"];
    print(status);
    if (status == "berhasil") {
      statushapusEval = "berhasil";
      laodinghapusval = false;
      notifyListeners();
    } else {
      statushapusEval = "gagal";
      laodinghapusval = false;
      notifyListeners();
    }
  }

  getSoalPretest() async {
    sharedPreferences = await SharedPreferences.getInstance();
    String? gelombang = sharedPreferences!.getString('gelombang');
    String? username = sharedPreferences!.getString('usernameLogin');
    var urltoken = Uri.parse('https://developer.ump.ac.id/token/index.php');
    var urllogin = Uri.parse('https://developer.ump.ac.id/PD/login.php');

    Map getToken = {
      "username": "pangkalandata",
      "password": "ump",
    };
    var tokenencode = json.encode(getToken);
    notifyListeners();
    var responseToken = await http.post(urltoken, body: tokenencode);
    var xtokenDecode = json.decode(responseToken.body);
    // ignore: avoid_print
    print(responseToken.body);
    var xtoken = xtokenDecode['response']['token'];
    // ignore: avoid_print
    print(xtoken);
    Map<String, String> headersxtoken = {"x-token": xtoken};

    var url = Uri.parse(
        'https://developer.ump.ac.id/PD/ramadhan1445/pretest_api.php');
    var body = {
      "USERNAME": username,
      "gelombang_id": gelombang,
      "perintah_id": "1",
    };
    var bodyencode = jsonEncode(body);
    var bodyResult =
        await http.post(url, headers: headersxtoken, body: bodyencode);
    // Map<String, dynamic> decodeDataLogin = jsonDecode(bodyResult.body);
    notifyListeners();
    var dataDecode = jsonDecode(bodyResult.body);
    print(dataDecode);
    if (dataDecode["metaData"]["code"] == "200") {
      datapretest = ModelPretest.fromJson(dataDecode);
      loadingSoalPretest = false;
      statuspretest = "buka";
      // soaljawbanid = [];
      // soaljawbantext = [];
      // if (statuspretest == "buka") {
      //   for (var i = 0; i < datapretest!.jawaban!.length; i++) {
      //     if (datapretest!.response![0].soalId ==
      //         datapretest!.jawaban![i].soalId) {
      //       int aa = int.parse(datapretest!.jawaban![i].pilId!);
      //       String bb = datapretest!.jawaban![i].pilJawaban!;
      //       soaljawbanid?.add(aa);
      //       soaljawbantext?.add(bb);
      //       print(aa);
      //     }
      //   }
      // }
      notifyListeners();
    } else if (dataDecode["metaData"]["code"] == "100") {
      dataErrorPretest = ModelSoalError.fromJson(dataDecode);
      statuspretest = "selesai";
      print(dataDecode["response"][0]["skor"]);
      skor = dataDecode["response"][0]["skor"];
      notifyListeners();
    } else if (dataDecode["metaData"]["code"] == "404") {
      dataErrorPretest = ModelSoalError.fromJson(dataDecode);
      statuspretest = "tutup";
      notifyListeners();
    }
  }

  kirimSoalPretestJawab(String? pilid, int? jawaban) async {
    sharedPreferences = await SharedPreferences.getInstance();
    String? gelombang = sharedPreferences!.getString('gelombang');
    String? username = sharedPreferences!.getString('usernameLogin');
    var urltoken = Uri.parse('https://developer.ump.ac.id/token/index.php');

    Map getToken = {
      "username": "pangkalandata",
      "password": "ump",
    };
    var tokenencode = json.encode(getToken);
    notifyListeners();
    var responseToken = await http.post(urltoken, body: tokenencode);
    var xtokenDecode = json.decode(responseToken.body);
    // ignore: avoid_print
    print(responseToken.body);
    var xtoken = xtokenDecode['response']['token'];
    // ignore: avoid_print
    print(xtoken);
    Map<String, String> headersxtoken = {"x-token": xtoken};

    var url = Uri.parse(
        'https://developer.ump.ac.id/PD/ramadhan1445/pretest_api.php');
    var body = {
      "USERNAME": username,
      "gelombang_id": gelombang,
      "perintah_id": "2",
      "soal_id": pilid,
      "pil_id": jawaban.toString()
    };
    var bodyencode = jsonEncode(body);
    var bodyResult =
        await http.post(url, headers: headersxtoken, body: bodyencode);
    // Map<String, dynamic> decodeDataLogin = jsonDecode(bodyResult.body);
    notifyListeners();
    var dataDecode = jsonDecode(bodyResult.body);
    if (dataDecode["metaData"]["code"] == "200") {
      kirimSoalPretest = false;
      notifyListeners();
    } else if (dataDecode["metaData"]["code"] == "404") {
      dataErrorPretest = ModelSoalError.fromJson(dataDecode);
      kirimSoalPretest = false;
    }
  }

  getSoalPos() async {
    sharedPreferences = await SharedPreferences.getInstance();
    String? gelombang = sharedPreferences!.getString('gelombang');
    String? username = sharedPreferences!.getString('usernameLogin');
    var urltoken = Uri.parse('https://developer.ump.ac.id/token/index.php');
    var urllogin = Uri.parse('https://developer.ump.ac.id/PD/login.php');

    Map getToken = {
      "username": "pangkalandata",
      "password": "ump",
    };
    var tokenencode = json.encode(getToken);
    notifyListeners();
    var responseToken = await http.post(urltoken, body: tokenencode);
    var xtokenDecode = json.decode(responseToken.body);
    // ignore: avoid_print
    print(responseToken.body);
    var xtoken = xtokenDecode['response']['token'];
    // ignore: avoid_print
    print(xtoken);
    Map<String, String> headersxtoken = {"x-token": xtoken};

    var url = Uri.parse(
        'https://developer.ump.ac.id/PD/ramadhan1445/posttest_api.php');
    var body = {
      "USERNAME": username,
      "gelombang_id": gelombang,
      "perintah_id": "1",
    };
    var bodyencode = jsonEncode(body);
    var bodyResult =
        await http.post(url, headers: headersxtoken, body: bodyencode);
    // Map<String, dynamic> decodeDataLogin = jsonDecode(bodyResult.body);
    notifyListeners();
    var dataDecode = jsonDecode(bodyResult.body);
    print(dataDecode);
    if (dataDecode["metaData"]["code"] == "200") {
      datapostest = ModelPretest.fromJson(dataDecode);
      loadingSoalPostest = false;
      statuspostest = "buka";
      // soaljawbanid = [];
      // soaljawbantext = [];
      // if (statuspretest == "buka") {
      //   for (var i = 0; i < datapretest!.jawaban!.length; i++) {
      //     if (datapretest!.response![0].soalId ==
      //         datapretest!.jawaban![i].soalId) {
      //       int aa = int.parse(datapretest!.jawaban![i].pilId!);
      //       String bb = datapretest!.jawaban![i].pilJawaban!;
      //       soaljawbanid?.add(aa);
      //       soaljawbantext?.add(bb);
      //       print(aa);
      //     }
      //   }
      // }
      notifyListeners();
    } else if (dataDecode["metaData"]["code"] == "100") {
      dataErrorPretest = ModelSoalError.fromJson(dataDecode);
      statuspostest = "selesai";
      print(dataDecode["response"][0]["skor"]);
      skor = dataDecode["response"][0]["skor"];
      notifyListeners();
    } else if (dataDecode["metaData"]["code"] == "404") {
      dataErrorPretest = ModelSoalError.fromJson(dataDecode);
      statuspostest = "tutup";
      notifyListeners();
    }
  }

  kirimSoalPostestJawab(String? pilid, int? jawaban) async {
    sharedPreferences = await SharedPreferences.getInstance();
    String? gelombang = sharedPreferences!.getString('gelombang');
    String? username = sharedPreferences!.getString('usernameLogin');
    var urltoken = Uri.parse('https://developer.ump.ac.id/token/index.php');

    Map getToken = {
      "username": "pangkalandata",
      "password": "ump",
    };
    var tokenencode = json.encode(getToken);
    notifyListeners();
    var responseToken = await http.post(urltoken, body: tokenencode);
    var xtokenDecode = json.decode(responseToken.body);
    // ignore: avoid_print
    print(responseToken.body);
    var xtoken = xtokenDecode['response']['token'];
    // ignore: avoid_print
    print(xtoken);
    Map<String, String> headersxtoken = {"x-token": xtoken};

    var url = Uri.parse(
        'https://developer.ump.ac.id/PD/ramadhan1445/posttest_api.php');
    var body = {
      "USERNAME": username,
      "gelombang_id": gelombang,
      "perintah_id": "2",
      "soal_id": pilid,
      "pil_id": jawaban.toString()
    };
    var bodyencode = jsonEncode(body);
    var bodyResult =
        await http.post(url, headers: headersxtoken, body: bodyencode);
    // Map<String, dynamic> decodeDataLogin = jsonDecode(bodyResult.body);
    notifyListeners();
    var dataDecode = jsonDecode(bodyResult.body);
    if (dataDecode["metaData"]["code"] == "200") {
      kirimSoalPostest = false;
      notifyListeners();
    } else if (dataDecode["metaData"]["code"] == "404") {
      dataErrorPretest = ModelSoalError.fromJson(dataDecode);
      kirimSoalPostest = false;
    }
  }

  getPengajian() async {
    sharedPreferences = await SharedPreferences.getInstance();
    String? gelombang = sharedPreferences!.getString('gelombang');
    String? username = sharedPreferences!.getString('usernameLogin');
    var urltoken = Uri.parse('https://developer.ump.ac.id/token/index.php');
    var urllogin = Uri.parse('https://developer.ump.ac.id/PD/login.php');

    Map getToken = {
      "username": "pangkalandata",
      "password": "ump",
    };
    var tokenencode = json.encode(getToken);
    notifyListeners();
    var responseToken = await http.post(urltoken, body: tokenencode);
    var xtokenDecode = json.decode(responseToken.body);
    // ignore: avoid_print
    print(responseToken.body);
    var xtoken = xtokenDecode['response']['token'];
    // ignore: avoid_print
    print("gelombang id ${gelombang}");
    Map<String, String> headersxtoken = {"x-token": xtoken};

    var url = Uri.parse(
        'https://developer.ump.ac.id/PD/ramadhan1445/presensi_sesi.php');
    var body = {
      "USERNAME": username,
      "gelombang_id": gelombang,
      "perintah_id": "1",
    };
    var bodyencode = jsonEncode(body);
    var bodyResult =
        await http.post(url, headers: headersxtoken, body: bodyencode);
    // Map<String, dynamic> decodeDataLogin = jsonDecode(bodyResult.body);
    notifyListeners();
    var dataDecode = jsonDecode(bodyResult.body);
    print(dataDecode);
    if (dataDecode["metaData"]["code"] == "200") {
      datapresensiRamdhadan = ModelPresensiRamadhan.fromJson(dataDecode);
      loadinggetpengajian = false;
      statuPresensiDibuka = "buka";
      // soaljawbanid = [];
      // soaljawbantext = [];
      // if (statuspretest == "buka") {
      //   for (var i = 0; i < datapretest!.jawaban!.length; i++) {
      //     if (datapretest!.response![0].soalId ==
      //         datapretest!.jawaban![i].soalId) {
      //       int aa = int.parse(datapretest!.jawaban![i].pilId!);
      //       String bb = datapretest!.jawaban![i].pilJawaban!;
      //       soaljawbanid?.add(aa);
      //       soaljawbantext?.add(bb);
      //       print(aa);
      //     }
      //   }
      // }
      notifyListeners();
      print(dataDecode["metaData"]["code"]);
    } else if (dataDecode["metaData"]["code"] == "400") {
      dataErrorPretest = ModelSoalError.fromJson(dataDecode);
      loadinggetpengajian = false;
      statuPresensiDibuka = "tutup";
      statuPresensiKet = dataDecode["metaData"]["message"];
      notifyListeners();
    } else {
      dataErrorPretest = ModelSoalError.fromJson(dataDecode);
      loadinggetpengajian = false;
      notifyListeners();
    }
  }

  kirimPresensiPengajian(String? hikmah) async {
    sharedPreferences = await SharedPreferences.getInstance();
    String? gelombang = sharedPreferences!.getString('gelombang');
    String? username = sharedPreferences!.getString('usernameLogin');
    var urltoken = Uri.parse('https://developer.ump.ac.id/token/index.php');

    Map getToken = {
      "username": "pangkalandata",
      "password": "ump",
    };
    var tokenencode = json.encode(getToken);
    notifyListeners();
    var responseToken = await http.post(urltoken, body: tokenencode);
    var xtokenDecode = json.decode(responseToken.body);
    // ignore: avoid_print
    print(responseToken.body);
    var xtoken = xtokenDecode['response']['token'];
    // ignore: avoid_print
    print(xtoken);
    Map<String, String> headersxtoken = {"x-token": xtoken};

    var url = Uri.parse(
        'https://developer.ump.ac.id/PD/ramadhan1445/presensi_sesi.php');
    var body = {
      "USERNAME": username,
      "gelombang_id": gelombang,
      "perintah_id": "2",
      "hikmah": hikmah
    };
    print(body);
    var bodyencode = jsonEncode(body);
    var bodyResult =
        await http.post(url, headers: headersxtoken, body: bodyencode);
    // Map<String, dynamic> decodeDataLogin = jsonDecode(bodyResult.body);
    notifyListeners();
    var dataDecode = jsonDecode(bodyResult.body);
    print(dataDecode["metaData"]);
    if (dataDecode["metaData"]["code"] == "200") {
      loadingkirimpresensi = false;
      presensistatus = "berhasil";
      notifyListeners();
    } else if (dataDecode["metaData"]["code"] == "404") {
      dataErrorPretest = ModelSoalError.fromJson(dataDecode);
      loadingkirimpresensi = false;
      presensistatus = "gagal";
    } else {
      loadingkirimpresensi = false;
      presensistatus = "gagal";
      notifyListeners();
    }
  }

  getDoa() async {
    // List<ResponseDoa> dataDoa = [];
    var url =
        Uri.parse('https://developer.ump.ac.id/PD/ramadhan1445/doaharian.php');
    var urltoken = Uri.parse('https://developer.ump.ac.id/token/index.php');
    Map getToken = {
      "username": "pangkalandata",
      "password": "ump",
    };
    var tokenencode = json.encode(getToken);
    var responseToken = await http.post(urltoken, body: tokenencode);
    var xtokenDecode = json.decode(responseToken.body);
    // ignore: avoid_print
    print(responseToken.body);
    var xtoken = xtokenDecode['response']['token'];
    // ignore: avoid_print
    print(xtoken);
    Map<String, String> headersxtoken = {"x-token": xtoken};
    var bodyResult = await http.post(
      url,
      headers: headersxtoken,
    );
    // Map<String, dynamic> decodeDataLogin = jsonDecode(bodyResult.body);
    notifyListeners();
    var dataDecode = jsonDecode(bodyResult.body);
    print(dataDecode);
    // dataDoa = ModelDoa.fromJson(dataDecode);

    if (dataDecode["metaData"]["code"] == "200") {
      dataDoa = ModelDoa.fromJson(dataDecode);

      loadingdoa = false;
      notifyListeners();
    } else if (dataDecode["metaData"]["code"] == "404") {
      dataErrorPretest = ModelSoalError.fromJson(dataDecode);
      loadingdoa = false;
    } else {
      loadingdoa = false;
      notifyListeners();
    }

    // soaljawbanid = [];
    // soaljawbantext = [];
    // if (statuspretest == "buka") {
    //   for (var i = 0; i < datapretest!.jawaban!.length; i++) {
    //     if (datapretest!.response![0].soalId ==
    //         datapretest!.jawaban![i].soalId) {
    //       int aa = int.parse(datapretest!.jawaban![i].pilId!);
    //       String bb = datapretest!.jawaban![i].pilJawaban!;
    //       soaljawbanid?.add(aa);
    //       soaljawbantext?.add(bb);
    //       print(aa);
    //     }
    //   }
    // }
  }

  getEvaluasiQusioner() async {
    sharedPreferences = await SharedPreferences.getInstance();
    String? gelombang = sharedPreferences!.getString('gelombang');
    String? username = sharedPreferences!.getString('usernameLogin');
    var urltoken = Uri.parse('https://developer.ump.ac.id/token/index.php');
    var urllogin = Uri.parse('https://developer.ump.ac.id/PD/login.php');

    Map getToken = {
      "username": "pangkalandata",
      "password": "ump",
    };
    var tokenencode = json.encode(getToken);
    notifyListeners();
    var responseToken = await http.post(urltoken, body: tokenencode);
    var xtokenDecode = json.decode(responseToken.body);
    // ignore: avoid_print
    print(responseToken.body);
    var xtoken = xtokenDecode['response']['token'];
    // ignore: avoid_print
    print(xtoken);
    Map<String, String> headersxtoken = {"x-token": xtoken};

    var url = Uri.parse(
        'https://developer.ump.ac.id/PD/ramadhan1445/evaluasi_kuesioner_api.php');
    var body = {
      "USERNAME": username,
      "gelombang_id": gelombang,
      "perintah_id": "1",
    };
    var bodyencode = jsonEncode(body);
    var bodyResult =
        await http.post(url, headers: headersxtoken, body: bodyencode);
    // Map<String, dynamic> decodeDataLogin = jsonDecode(bodyResult.body);
    notifyListeners();
    var dataDecode = jsonDecode(bodyResult.body);
    print(dataDecode);
    if (dataDecode["metaData"]["code"] == "200") {
      dataquisioner = ModelEvaluasiQuisioner.fromJson(dataDecode);
      loadingSoalPostest = false;
      statusquisioner = "buka";
      // soaljawbanid = [];
      // soaljawbantext = [];
      // if (statuspretest == "buka") {
      //   for (var i = 0; i < datapretest!.jawaban!.length; i++) {
      //     if (datapretest!.response![0].soalId ==
      //         datapretest!.jawaban![i].soalId) {
      //       int aa = int.parse(datapretest!.jawaban![i].pilId!);
      //       String bb = datapretest!.jawaban![i].pilJawaban!;
      //       soaljawbanid?.add(aa);
      //       soaljawbantext?.add(bb);
      //       print(aa);
      //     }
      //   }
      // }
      notifyListeners();
    } else if (dataDecode["metaData"]["code"] == "100") {
      dataErrorPretest = ModelSoalError.fromJson(dataDecode);
      statusquisioner = "selesai";
      print(dataDecode["response"][0]["skor"]);
      skor = dataDecode["response"][0]["skor"];
      notifyListeners();
    } else if (dataDecode["metaData"]["code"] == "404") {
      dataErrorPretest = ModelSoalError.fromJson(dataDecode);
      statusquisioner = "tutup";
      notifyListeners();
    }
  }

  kirimEvaluasiQusioner(String? pilid, int? jawaban) async {
    sharedPreferences = await SharedPreferences.getInstance();
    String? gelombang = sharedPreferences!.getString('gelombang');
    String? username = sharedPreferences!.getString('usernameLogin');
    var urltoken = Uri.parse('https://developer.ump.ac.id/token/index.php');

    Map getToken = {
      "username": "pangkalandata",
      "password": "ump",
    };
    var tokenencode = json.encode(getToken);
    notifyListeners();
    var responseToken = await http.post(urltoken, body: tokenencode);
    var xtokenDecode = json.decode(responseToken.body);
    // ignore: avoid_print
    print(responseToken.body);
    var xtoken = xtokenDecode['response']['token'];
    // ignore: avoid_print
    print(xtoken);
    Map<String, String> headersxtoken = {"x-token": xtoken};

    var url = Uri.parse(
        'https://developer.ump.ac.id/PD/ramadhan1445/evaluasi_kuesioner_api.php');
    var body = {
      "USERNAME": username,
      "gelombang_id": gelombang,
      "perintah_id": "2",
      "soal_id": pilid,
      "pil_id": jawaban.toString()
    };
    var bodyencode = jsonEncode(body);
    var bodyResult =
        await http.post(url, headers: headersxtoken, body: bodyencode);
    // Map<String, dynamic> decodeDataLogin = jsonDecode(bodyResult.body);
    notifyListeners();
    var dataDecode = jsonDecode(bodyResult.body);
    if (dataDecode["metaData"]["code"] == "200") {
      kirimquisioner = false;
      notifyListeners();
    } else if (dataDecode["metaData"]["code"] == "404") {
      dataErrorPretest = ModelSoalError.fromJson(dataDecode);
      kirimquisioner = false;
    }
  }

  getRekapPresensiRamadhan() async {
    sharedPreferences = await SharedPreferences.getInstance();
    String? gelombang = sharedPreferences!.getString('gelombang');
    String? username = sharedPreferences!.getString('usernameLogin');
    var urltoken = Uri.parse('https://developer.ump.ac.id/token/index.php');

    Map getToken = {
      "username": "pangkalandata",
      "password": "ump",
    };
    var tokenencode = json.encode(getToken);
    notifyListeners();
    var responseToken = await http.post(urltoken, body: tokenencode);
    var xtokenDecode = json.decode(responseToken.body);
    // ignore: avoid_print
    print(responseToken.body);
    var xtoken = xtokenDecode['response']['token'];
    // ignore: avoid_print
    print(xtoken);
    Map<String, String> headersxtoken = {"x-token": xtoken};

    var url = Uri.parse(
        'https://developer.ump.ac.id/PD/ramadhan1445/presensi_sesi_detail.php');
    var body = {
      "USERNAME": username,
      "gelombang_id": gelombang,
      "perintah_id": "1",
    };
    var bodyencode = jsonEncode(body);
    var bodyResult =
        await http.post(url, headers: headersxtoken, body: bodyencode);
    // Map<String, dynamic> decodeDataLogin = jsonDecode(bodyResult.body);
    notifyListeners();
    var dataDecode = jsonDecode(bodyResult.body);
    if (dataDecode["metaData"]["code"] == "200") {
      rekappresensiramadhan = ModelRekapPresensiRamdhan.fromJson(dataDecode);
      rekaploadingramadhan = false;
      notifyListeners();
    } else if (dataDecode["metaData"]["code"] == "404") {
      rekaploadingramadhan = false;
      notifyListeners();
    }
  }

  getSertifikat() async {
    sharedPreferences = await SharedPreferences.getInstance();
    String? gelombang = sharedPreferences!.getString('gelombang');
    String? username = sharedPreferences!.getString('usernameLogin');
    var urltoken = Uri.parse('https://developer.ump.ac.id/token/index.php');

    Map getToken = {
      "username": "pangkalandata",
      "password": "ump",
    };
    var tokenencode = json.encode(getToken);
    notifyListeners();
    var responseToken = await http.post(urltoken, body: tokenencode);
    var xtokenDecode = json.decode(responseToken.body);
    // ignore: avoid_print
    print(responseToken.body);
    var xtoken = xtokenDecode['response']['token'];
    // ignore: avoid_print
    print(xtoken);
    Map<String, String> headersxtoken = {"x-token": xtoken};

    var url =
        Uri.parse('https://developer.ump.ac.id/PD/ramadhan1445/sertifikat.php');
    var body = {
      "USERNAME": username,
      "gelombang_id": gelombang,
      "perintah_id": "1",
    };
    var bodyencode = jsonEncode(body);
    var bodyResult =
        await http.post(url, headers: headersxtoken, body: bodyencode);
    // Map<String, dynamic> decodeDataLogin = jsonDecode(bodyResult.body);
    notifyListeners();
    var dataDecode = jsonDecode(bodyResult.body);
    print(dataDecode["metaData"]["code"]);
    if (dataDecode["metaData"]["code"] == "200") {
      link = dataDecode["response"][0]["link"];
      statussertifikat = "buka";
      loadingsertifikat = false;
      notifyListeners();
    } else if (dataDecode["metaData"]["code"] == "400") {
      link = dataDecode["metaData"]["message"];
      statussertifikat = "tutup";
      loadingsertifikat = false;
      notifyListeners();
    }
  }

  // Logbook Untuk MANDIRI dan EKSTERNAL
  Future<void> getDataLogbook() async {
    try {
      sharedPreferences = await SharedPreferences.getInstance();
      String? gelombang = sharedPreferences?.getString('gelombang');
      String? username = sharedPreferences?.getString('usernameLogin');

      if (gelombang == null || username == null) {
        // Handle case when gelombang or username is null
        return;
      }

      String xtoken = await _getToken();

      Map<String, String> headersxtoken = {"x-token": xtoken};

      var url =
          Uri.parse('https://developer.ump.ac.id/PD/ramadhan1445/logbook.php');
      var body = {
        "USERNAME": username,
        "gelombang_id": gelombang,
        "perintah_id": "1",
      };

      var bodyencode = jsonEncode(body);

      var bodyResult =
          await http.post(url, headers: headersxtoken, body: bodyencode);

      loadingLogbookRamadhan = true;
      notifyListeners();
      var dataDecode = jsonDecode(bodyResult.body);
      print(dataDecode);

      if (dataDecode['metaData']['code'] == "200") {
        List<Map<String, dynamic>> logbookList =
            List<Map<String, dynamic>>.from(dataDecode['response']);
        dataLogbook = ModelLogbook1445.fromJson(dataDecode);
        dataLogbook?.sortByDateDesc();
      } else {
        // Handle non-OK response (code other than 200)
        print('Error: ${dataDecode['metaData']['message']}');
        loadingLogbookRamadhan = false;
      }
    } catch (error) {
      // Handle any unexpected errors
      print("Error in getDataLogbook: $error");
    }
  }

  Future<String> _getToken() async {
    var urltoken = Uri.parse('https://developer.ump.ac.id/token/index.php');
    Map<String, String> getToken = {
      "username": "pangkalandata",
      "password": "ump",
    };

    var tokenencode = json.encode(getToken);
    notifyListeners();

    var responseToken = await http.post(urltoken, body: tokenencode);
    var xtokenDecode = json.decode(responseToken.body);
    print(responseToken.body);

    var xtoken = xtokenDecode['response']['token'];
    print("gelombang id $gelombang");

    return xtoken;
  }


  // Get Data Kegiatan
  List<Kegiatan> listKegiatan = [];
  Future<void> getKegiatan() async {
  try {
    sharedPreferences = await SharedPreferences.getInstance();
    String? gelombang = sharedPreferences?.getString('gelombang');
    String? username = sharedPreferences?.getString('usernameLogin');

    var url = Uri.parse(
        'https://developer.ump.ac.id/PD/ramadhan1445/jenis_kegiatan.php');
    var body = {
      "USERNAME": username,
      "gelombang_id": gelombang,
      "perintah_id": "1",
    };
    var bodyencode = jsonEncode(body);
    var bodyResult = await http.post(url, body: bodyencode);
    
    notifyListeners();
    var dataDecode = jsonDecode(bodyResult.body);
    var modelKegiatan = ModelKegiatan1445.fromJson(dataDecode);

    // Setelah mendapatkan data, kita ingin mengisi daftar kegiatan untuk dropdown
    listKegiatan.clear();
    if (modelKegiatan.response != null) {
      for (var kegiatan in modelKegiatan.response!) {
        listKegiatan.add(Kegiatan(kegiatan.jenisKegiatanId!, kegiatan.jenisKegiatan!));
      }
    }

    print("Data Kegiatan : $dataDecode");
  } catch (e) {
    loading = false;
  }
}

}
