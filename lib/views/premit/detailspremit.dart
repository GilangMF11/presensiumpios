import 'dart:convert';
import 'dart:typed_data';

import 'package:attedancekaryawanump/views/premit/editpremit.dart';
import 'package:attedancekaryawanump/views/utils/version.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class DetailsPremit extends StatefulWidget {
  int? id;
  int? alasan;
  String? widTanggaMulai;
  String? widTanggaSelesai;
  String? keterangan;
  String? gambar;
  DetailsPremit(
      {this.id,
      this.alasan,
      this.widTanggaMulai,
      this.widTanggaSelesai,
      this.keterangan,
      this.gambar});

  @override
  _DetailsPremitState createState() => _DetailsPremitState();
}

class _DetailsPremitState extends State<DetailsPremit> {
  SharedPreferences? sharedPreferences;
  String version = Version().version;
  String? alasan;

  deleteData() async {
    var url = Uri.parse(
        'https://attendance.ump.ac.id/api/v1/permit/delete/${widget.id}');
    sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences?.getString('token');
    Map<String, String> head = {
      'Accept': 'application/json',
      'User-Agent': 'neoPresensiAndroid',
      'X-Authorization': token!,
      'version': version
    };
    var datalogin = await http.delete(url, headers: head);
    var dataloginen = datalogin.body;
    var dataDecode = jsonDecode(datalogin.body);
    print(dataDecode);

    bool? stat = dataDecode['status'];
    String? message = dataDecode['message'];
    if (stat == true) {
      int count = 0;
      Navigator.of(context).popUntil((_) => count++ >= 2);
      Fluttertoast.showToast(
          msg: message ?? "Data Berhasil dihapus",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xFF0a4f8f),
          textColor: Colors.white,
          fontSize: 16.0);
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
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.alasan == 1) {
        setState(() {
          alasan = "Sakit";
        });
      } else if (widget.alasan == 2) {
        setState(() {
          alasan = "Ijin";
        });
      } else if (widget.alasan == 3) {
        setState(() {
          alasan = "Dinas Luar";
        });
      } else if (widget.alasan == 4) {
        setState(() {
          alasan = "Cuti";
        });
      } else if (widget.alasan == 5) {
        setState(() {
          alasan = "Izin Belajar";
        });
      }
    });
  }

  bool _expanded = false;
  bool _expanded2 = false;
  bool _expanded3 = false;
  @override
  Widget build(BuildContext context) {
    print("hasil gambar : ${widget.gambar}");
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF0a4f8f),
        title: Text(
          'Details Perizinan',
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
                    ],
                  ),
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
                              color: Color(0xFF2b7cc4),
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(5),
                                  topRight: Radius.circular(5))),
                          // width: MediaQuery.of(context).size.width,
                          child: Text(
                            'Rincian Perizinan',
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
                                    'Alasan : ',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 11.sp),
                                  ),
                                  SizedBox(
                                    height: 0.5.h,
                                  ),
                                  Text(
                                    alasan ?? "",
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
                                    'Tanggal Mulai :',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 11.sp),
                                  ),
                                  SizedBox(
                                    height: 0.5.h,
                                  ),
                                  Text(
                                    widget.widTanggaMulai ?? "",
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
                                    'Tanggal Selesai :',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 11.sp),
                                  ),
                                  SizedBox(
                                    height: 0.5.h,
                                  ),
                                  Text(
                                    widget.widTanggaSelesai ?? "",
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
                                    'Deskripsi :',
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
                                                Navigator.of(context)
                                                    .push(MaterialPageRoute(
                                                      builder: (context) => EditPremit(
                                                          id: widget.id,
                                                          alasan: widget.alasan,
                                                          widTanggaMulai: widget
                                                              .widTanggaMulai,
                                                          widTanggaSelesai: widget
                                                              .widTanggaSelesai,
                                                          keterangan:
                                                              widget.keterangan,
                                                          gambar:
                                                              widget.gambar),
                                                    ))
                                                    .then((value) {});
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
              ),
              Padding(
                padding: EdgeInsets.only(left: 4.w, right: 4.w, top: 2.h),
                child: ExpansionPanelList(
                  animationDuration: Duration(milliseconds: 600),
                  children: [
                    ExpansionPanel(
                      headerBuilder: (context, isExpanded) {
                        return ListTile(
                          title: Text(
                            'Foto Bukti Izin',
                            style:
                                TextStyle(color: Colors.black, fontSize: 10.sp),
                          ),
                        );
                      },
                      body: SingleChildScrollView(
                        child: Container(
                          height: 30.h,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.white,
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 30.h,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            "https://attendance.ump.ac.id/assets/images/${widget.gambar}"))),
                              ),
                            ],
                          ),
                        ),
                      ),
                      isExpanded: _expanded,
                      canTapOnHeader: true,
                    ),
                  ],
                  dividerColor: Colors.grey,
                  expansionCallback: (panelIndex, isExpanded) {
                    setState(() {
                      _expanded = !_expanded;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
        setState(() {
          deleteData();
        });
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
