import 'dart:convert';

import 'package:attedancekaryawanump/views/ramadhan/1445h/logbook/v_logbook1445.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class EditLogbookRamadhan1445 extends StatefulWidget {
  int? id;
  String? tanggal;
  String? widJamMulai;
  String? widJamSelesai;
  String? jKegiatan;
  String? keterangan;

  EditLogbookRamadhan1445(
      {this.id,
      this.tanggal,
      this.jKegiatan,
      this.widJamMulai,
      this.widJamSelesai,
      this.keterangan});

  @override
  State<EditLogbookRamadhan1445> createState() =>
      _EditLogbookRamadhan1445State();
}

class _EditLogbookRamadhan1445State extends State<EditLogbookRamadhan1445> {
  var currentSelectedValue;
  var flag;
  final ketController = TextEditingController();
  final tglController = TextEditingController();
  final jamMulai = TextEditingController();
  final jamSelesai = TextEditingController();
  final kegiatan = TextEditingController();
  List<String> jenisKegiatan = [
    "Sholat Malam",
    "Tadarus",
    "Kultum",
    "Dzikir",
    "Lainnya"
  ];

  SharedPreferences? sharedPreferences;
  bool isLoading = false;

  _kirim(String? tanggal, String? jamMulai, String? jamSelesai,
      String? keterangan, String? kegiatan, int? id) async {
    if (tanggal == "") {
      setState(() {
        isLoading = false;
        Fluttertoast.showToast(
            msg: "Tanggal Masih Kosong!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      });
    } else if (kegiatan == "") {
      setState(() {
        isLoading = false;
        Fluttertoast.showToast(
            msg: "Kegiatan Masih Kosong!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      });
    } else if (jamMulai == "") {
      setState(() {
        isLoading = false;
        Fluttertoast.showToast(
            msg: "Jam Mulai Masih Kosong!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      });
    } else if (jamSelesai == "") {
      setState(() {
        isLoading = false;
        Fluttertoast.showToast(
            msg: "Jam Selesai Masih Kosong!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      });
    } else if (keterangan == "") {
      setState(() {
        isLoading = false;
        Fluttertoast.showToast(
            msg: "Keterangan Masih Kosong!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      });
    } else {
      try {
        var flag;
        var url = Uri.parse(
            'https://developer.ump.ac.id/PD/ramadhan1445/logbook.php');
        sharedPreferences = await SharedPreferences.getInstance();
        String? gelombang = sharedPreferences!.getString('gelombang');
        String? username = sharedPreferences!.getString('usernameLogin');

        // ignore: unrelated_type_equality_checks
        if (kegiatan == "Sholat Malam") {
          setState(() {
            flag = "1";
          });
        } else if (kegiatan == "Tadarus") {
          setState(() {
            flag = "2";
          });
        } else if (kegiatan == "Kultum") {
          setState(() {
            flag = "3";
          });
        } else if (kegiatan == "Dzikir") {
          setState(() {
            flag = "4";
          });
        } else if (kegiatan == "Lainnya") {
          setState(() {
            flag = "5";
          });
        }

        Map data = {
          "USERNAME": username,
          "gelombang_id": gelombang,
          "perintah_id": "2",
          "tanggal": tanggal,
          "jenis_kegiatan_id": flag,
          "jam_mulai": jamMulai,
          "jam_akhir": jamSelesai,
          "keterangan": keterangan,
          "logbook_id": id
        };

        Map<String, String> head = {
          'Accept': 'application/json',
          'User-Agent': 'neoPresensiAndroid',
        };

        var body = jsonEncode(data);
        var dataLogin = await http.post(url, headers: head, body: body);
        var dataLoginEncode = dataLogin.body;
        var dataDecode = jsonDecode(dataLogin.body);
        print("Hasil: $dataDecode");
        print("Username : $username");
        print("Gelombang ID : $gelombang");
        print("kegiatan: $flag");
        print("Tanggal : $tanggal");
        print("Jam Mulai : $jamMulai");
        print("Jam Akhir $jamSelesai");
        print("Keterangan $keterangan");

        if (dataDecode != null) {
          if (dataDecode['ket'] == "OK.berhasil update data") {
            isLoading = false;
            Fluttertoast.showToast(
                msg: "Berhasil Diperbarui!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: const Color(0xFF0a4f8f),
                textColor: Colors.white,
                fontSize: 16.0);
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => const LogBookRamadhan1445()),
                (Route<dynamic> route) => true);
          } else {
            Navigator.of(context).pop();
            Fluttertoast.showToast(
                msg: "LogBook Belum Dibuka!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        }
      } catch (e) {
        Navigator.of(context).pop();
        Fluttertoast.showToast(
            msg: "Error $e",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }

  setUpdate() {
    tglController.text = widget.tanggal.toString().substring(0, 10);
    jamMulai.text = widget.widJamMulai ?? "";
    jamSelesai.text = widget.widJamSelesai ?? "";
    //jenisKegiatan = (widget.jKegiatan ?? "") as List<String>;
    ketController.text = widget.keterangan ?? "";
    kegiatan.text = widget.jKegiatan ?? "";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await setUpdate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: isLoading == false
          ? SizedBox(
              height: 15.h,
              width: 15.w,
              child: FloatingActionButton(
                elevation: 0,
                onPressed: () {
                  _kirim(tglController.text, jamMulai.text, jamSelesai.text,
                      ketController.text, currentSelectedValue, widget.id);
                },
                child: Text(
                  "Update",
                  style: TextStyle(fontSize: 10.sp),
                ),
                backgroundColor: const Color.fromARGB(255, 223, 84, 56),
              ),
            )
          : SizedBox(
              height: 15.h,
              width: 15.w,
              child: FloatingActionButton(
                  elevation: 2,
                  onPressed: () {
                    setState(() {
                      isLoading == false;
                    });
                  },
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.grey),
            ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF1d8b61),
        title: Text(
          'Edit Logbook',
          style: TextStyle(fontSize: 12.sp),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 3.w, right: 3.w, top: 3.w),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 2.h),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(1),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pilih Tanggal',
                            style: TextStyle(fontSize: 12.sp),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 0.5,
                                  blurRadius: 2,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                )
                              ],
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    readOnly: true,
                                    controller: tglController,
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(fontSize: 11.sp),
                                      hintText: 'Tanggal Mulai',
                                      border: InputBorder.none,
                                    ),
                                    onTap: () async {
                                      var date = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime(2100));
                                      tglController.text =
                                          date.toString().substring(0, 10);
                                      // print(dateController.text);
                                    },
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xFF000000)),
                                  child: Icon(
                                    Icons.calendar_month,
                                    color: Colors.white,
                                    size: 6.w,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Container(
                      padding: const EdgeInsets.all(1),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Kegiatan",
                            style: TextStyle(fontSize: 12.sp),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 0.5,
                                    blurRadius: 2,
                                    offset: const Offset(0, 3),
                                  )
                                ],
                              ),
                              child: TextField(
                                readOnly: true,
                                controller: kegiatan,
                                decoration: InputDecoration(
                                    hintStyle: TextStyle(fontSize: 11.sp),
                                    hintText: "Kegiatan",
                                    border: InputBorder.none),
                              ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: 5,
                            child: Container(
                              padding: EdgeInsets.all(1),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Mulai',
                                    style: TextStyle(fontSize: 12.sp),
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Container(
                                    color: Colors.white,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            readOnly: true,
                                            controller: jamMulai,
                                            decoration: InputDecoration(
                                              hintStyle:
                                                  TextStyle(fontSize: 11.sp),
                                              hintText: 'Jam Mulai',
                                              border: InputBorder.none,
                                            ),
                                            onTap: () async {
                                              var date = await showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.now(),
                                                  builder: (context, child) {
                                                    return MediaQuery(
                                                      data: MediaQuery.of(
                                                              context)
                                                          .copyWith(
                                                              alwaysUse24HourFormat:
                                                                  true),
                                                      child: child!,
                                                    );
                                                  });
                                              jamMulai.text = date
                                                  .toString()
                                                  .substring(10, 15);
                                              // print(timemulai.text);
                                            },
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: const Color(0xFF2b7cc4),
                                          ),
                                          child: Icon(
                                            Icons.timelapse_outlined,
                                            color: Colors.white,
                                            size: 6.w,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        SizedBox(
                          width: 3.w,
                        ),
                        Expanded(
                            flex: 5,
                            child: Container(
                              padding: EdgeInsets.all(1),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Akhir',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.1),
                                          spreadRadius: 0.5,
                                          blurRadius: 2,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        )
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            readOnly: true,
                                            controller: jamSelesai,
                                            decoration: InputDecoration(
                                              hintStyle:
                                                  TextStyle(fontSize: 11.sp),
                                              hintText: 'Jam Akhir',
                                              border: InputBorder.none,
                                            ),
                                            onTap: () async {
                                              var date = await showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.now(),
                                                  builder: (context, child) {
                                                    return MediaQuery(
                                                      data: MediaQuery.of(
                                                              context)
                                                          .copyWith(
                                                              alwaysUse24HourFormat:
                                                                  true),
                                                      child: child!,
                                                    );
                                                  });
                                              jamSelesai.text = date
                                                  .toString()
                                                  .substring(10, 15);
                                              // print(timeakhir.text);
                                            },
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Color(0xFF2b7cc4),
                                          ),
                                          child: Icon(
                                            Icons.timelapse_outlined,
                                            color: Colors.white,
                                            size: 6.w,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ))
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Keterangan',
                    style: TextStyle(
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        // color: const Color(0xff7c94b6),
                        color: Colors.white,
                        // border: Border.all(
                        //   color: Colors.black87,
                        //   width: 0.5,
                        // ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 0.5,
                            blurRadius: 2,
                            offset: Offset(0, 3), // changes position of shadow
                          )
                        ],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                          child: TextField(
                        controller: ketController,
                        maxLines: 8,
                        style: TextStyle(),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(fontSize: 11.sp),
                            hintText: "Isi Keterangan"),
                      ))),
                  SizedBox(
                    height: 3.h,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
