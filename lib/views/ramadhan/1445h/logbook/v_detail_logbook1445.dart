import 'dart:convert';
import 'dart:ui';

import 'package:attedancekaryawanump/views/ramadhan/1445h/logbook/v_edit_logbook1445.dart';
import 'package:attedancekaryawanump/views/ramadhan/1445h/logbook/v_logbook1445.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class DetailLogBookRamadhan1445 extends StatefulWidget {
  int? id;
  String? tanggal;
  String? widJamMulai;
  String? widJamSelesai;
  String? jKegiatan;
  String? keterangan;

  DetailLogBookRamadhan1445(
      {this.id,
      this.tanggal,
      this.widJamMulai,
      this.widJamSelesai,
      this.jKegiatan,
      this.keterangan});

  @override
  State<DetailLogBookRamadhan1445> createState() =>
      _DetailLogBookRamadhan1445State();
}

class _DetailLogBookRamadhan1445State extends State<DetailLogBookRamadhan1445> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF1d8b61),
        title: Text(
          "Detail Logbook",
          style: TextStyle(fontSize: 12.sp),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 4.w, right: 4.w, top: 2.h),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 0.4,
                            offset: Offset(0.0, 0.10))
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: 2.h,
                          left: 3.w,
                          right: 3.w,
                        ),
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 1.h, left: 2.w, bottom: 1.h, right: 2.w),
                          decoration: const BoxDecoration(
                              color: Color(0xFF0a4f8f),
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(5),
                                  topRight: Radius.circular(5))),
                          // width: MediaQuery.of(context).size.width,
                          child: Text(
                            'Rincian Log Book',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: 2.h, left: 5.w, right: 5.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  top: 1.h, left: 2.w, bottom: 1.h),
                              decoration: BoxDecoration(
                                  color: Color(0xFFF6F8FD),
                                  borderRadius: BorderRadius.circular(5)),
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Tanggal :',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 11.sp),
                                  ),
                                  SizedBox(
                                    height: 0.5.h,
                                  ),
                                  Text(
                                    widget.tanggal.toString().substring(0, 10),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                        fontSize: 11.sp),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  top: 1.h, left: 2.w, bottom: 1.h),
                              decoration: BoxDecoration(
                                  color: Color(0xFFF6F8FD),
                                  borderRadius: BorderRadius.circular(5)),
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Kegiatan :',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 11.sp),
                                  ),
                                  SizedBox(
                                    height: 0.5.h,
                                  ),
                                  Text(
                                    widget.jKegiatan ?? "",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                        fontSize: 11.sp),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  top: 1.h, left: 2.w, bottom: 1.h),
                              decoration: BoxDecoration(
                                  color: Color(0xFFF6F8FD),
                                  borderRadius: BorderRadius.circular(5)),
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Jam Mulai :',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 11.sp),
                                  ),
                                  SizedBox(
                                    height: 0.5.h,
                                  ),
                                  Text(
                                    widget.widJamMulai ?? "",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                        fontSize: 11.sp),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  top: 1.h, left: 2.w, bottom: 1.h),
                              decoration: BoxDecoration(
                                  color: Color(0xFFF6F8FD),
                                  borderRadius: BorderRadius.circular(5)),
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Jam Selesai :',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 11.sp),
                                  ),
                                  SizedBox(
                                    height: 0.5.h,
                                  ),
                                  Text(
                                    widget.widJamSelesai ?? "",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                        fontSize: 11.sp),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  top: 1.h, left: 2.w, bottom: 1.h),
                              decoration: BoxDecoration(
                                  color: Color(0xFFF6F8FD),
                                  borderRadius: BorderRadius.circular(5)),
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Keterangan :',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 11.sp),
                                  ),
                                  SizedBox(
                                    height: 0.5.h,
                                  ),
                                  Text(
                                    widget.keterangan ?? "",
                                    maxLines: 4,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                        fontSize: 11.sp),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  top: 1.h, left: 2.w, bottom: 1.h),
                              decoration: BoxDecoration(
                                  color: Color(0xFFF6F8FD),
                                  borderRadius: BorderRadius.circular(5)),
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Text(
                                      'Modifikasi Data :',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 11.sp),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 0.5.h,
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 2.w, right: 2.w),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: 5,
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            EditLogbookRamadhan1445(
                                                              id: widget.id,
                                                              tanggal: widget
                                                                  .tanggal,
                                                              widJamMulai: widget
                                                                  .widJamMulai,
                                                              widJamSelesai: widget
                                                                  .widJamSelesai,
                                                              keterangan: widget
                                                                  .keterangan,
                                                              jKegiatan: widget
                                                                  .jKegiatan,
                                                            )));
                                              },
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    top: 1.h,
                                                    left: 2.w,
                                                    right: 2.w,
                                                    bottom: 1.h),
                                                decoration: BoxDecoration(
                                                    color:
                                                        Colors.green.shade800,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Center(
                                                  child: Text(
                                                    "Edit",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.white,
                                                        fontSize: 11.sp),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 3.h,
                                          ),
                                          Expanded(
                                            flex: 5,
                                            child: InkWell(
                                              onTap: () {
                                                showAlertDialog(context);
                                              },
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    top: 1.h,
                                                    left: 2.w,
                                                    right: 2.w,
                                                    bottom: 1.h),
                                                decoration: BoxDecoration(
                                                    color: Color.fromARGB(
                                                        255, 223, 84, 56),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Center(
                                                  child: Text(
                                                    "Hapus",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.white,
                                                        fontSize: 11.sp),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  deleteData(int? id) async {
    try {
      var url =
          Uri.parse('https://developer.ump.ac.id/PD/ramadhan1445/logbook.php');
      SharedPreferences? sharedPreferences;
      sharedPreferences = await SharedPreferences.getInstance();
      String? gelombang = sharedPreferences.getString('gelombang');
      String? username = sharedPreferences.getString('usernameLogin');

      Map<String, String> head = {
        'Accept': 'application/json',
        'User-Agent': 'neoPresensiAndroid',
      };
      var body = {
        "USERNAME": username,
        "gelombang_id": gelombang,
        "perintah_id": "3",
        "logbook_id": id
      };

      var bodyencode = jsonEncode(body);

      var data = await http.post(url, headers: head, body: bodyencode);
      var dataLogbook = data.body;
      var dataDecode = jsonDecode(dataLogbook);
      print(dataDecode);
      String? keterangan = dataDecode['ket'];
      if (keterangan == "berhasil") {
        int count = 0;
        Navigator.of(context).popUntil((_) => count++ >= 3);
        Fluttertoast.showToast(
            msg: "Data Berhasil dihapus",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: const Color(0xFF0a4f8f),
            textColor: Colors.white,
            fontSize: 16.0);

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => const LogBookRamadhan1445()),
            (Route<dynamic> route) => true);
      } else {
        Fluttertoast.showToast(
            msg: "Hapus gagal",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      print("Kesalahan pada Hapus : $e");
    }
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget Hapusbutton = TextButton(
      child: Text(
        "Cancel",
        style: TextStyle(color: Colors.black, fontSize: 10.sp),
      ),
      onPressed: () {
        setState(() {
          Navigator.of(context).pop();
        });
      },
    );

    Widget CancelButton = TextButton(
      child: Text(
        "Hapus",
        style: TextStyle(color: Colors.black, fontSize: 10.sp),
      ),
      onPressed: () {
        deleteData(widget.id);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Peringat!!",
        style: TextStyle(color: Colors.yellow.shade900, fontSize: 14.sp),
      ),
      content: Text(
        "Apakah anda akan menghapus data ini?",
        style: TextStyle(color: Colors.black, fontSize: 11.sp),
      ),
      actions: [Hapusbutton, CancelButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  listJadwal(String? no, String? hari, String? jammulai, String? jamselesai,
      String? kuota) {
    return Padding(
      padding:
          EdgeInsets.only(top: 0.5.h, bottom: 0.5.h, left: 5.w, right: 5.w),
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          color: Colors.grey.shade400,
          width: 1.0,
        ))),
        height: 3.h,
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    no ?? "",
                    style: TextStyle(fontSize: 10.sp),
                  ),
                )),
            Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    hari ?? "",
                    style: TextStyle(fontSize: 10.sp),
                  ),
                )),
            Expanded(
                flex: 3,
                child: Center(
                  child: Text(
                    jammulai ?? "",
                    style: TextStyle(fontSize: 10.sp),
                  ),
                )),
            Expanded(
                flex: 3,
                child: Center(
                  child: Text(
                    jamselesai ?? "",
                    style: TextStyle(fontSize: 10.sp),
                  ),
                )),
            Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    kuota ?? "",
                    style: TextStyle(fontSize: 10.sp),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
