import 'dart:convert';
import 'dart:io';

import 'package:attedancekaryawanump/views/provider/ramadhan/1445h/model/kegiatanModel1445.dart';
import 'package:attedancekaryawanump/views/provider/ramadhan/1445h/providerRamadhan1445.dart';
import 'package:attedancekaryawanump/views/ramadhan/1445h/logbook/v_logbook1445.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class AddLogBook1445 extends StatefulWidget {
  const AddLogBook1445({Key? key}) : super(key: key);

  @override
  State<AddLogBook1445> createState() => _AddLogBook1445State();
}

class _AddLogBook1445State extends State<AddLogBook1445> {
  var currentSelectedValue;
  final ketController = TextEditingController();
  final tglController = TextEditingController();
  final jamMulai = TextEditingController();
  final jamSelesai = TextEditingController();
  // List<String> jenisKegiatan = [
  //   "Sholat Malam",
  //   "Tadarus",
  //   "Kultum",
  //   "Dzikir",
  //   "Lainnya"
  // ];
  var dropdownKegiatan;

  SharedPreferences? sharedPreferences;
  bool isLoading = false;
  File? _image;
  String? fileInBase64;
  bool? loadingKegiatan;

  // Get kegiatan
  getKegiatan() async {
    final _providerkegiatan =
        Provider.of<ProviderRamadhan1445>(context, listen: false);
    await _providerkegiatan.getKegiatan();
    setState(() {
      loadingKegiatan = _providerkegiatan.loading;
    });
  }

  _kirim(String? tanggal, String? jamMulai, String? jamSelesai,
      String? keterangan, String? kegiatan, String? foto) async {
    if (fileInBase64 == null) {
      setState(() {
        isLoading = false;
        Fluttertoast.showToast(
            msg: "Foto Belum Ada",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      });
    } else if (tanggal == "") {
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
    } else if (dropdownKegiatan == "") {
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

        

        Map data = {
          "USERNAME": username,
          "gelombang_id": gelombang,
          "perintah_id": "2",
          "tanggal": tanggal,
          "jenis_kegiatan_id": kegiatan,
          "jam_mulai": jamMulai,
          "jam_akhir": jamSelesai,
          "keterangan": keterangan,
          "foto": foto
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
        print("kegiatan: $kegiatan");
        print("Tanggal : $tanggal");
        print("Jam Mulai : $jamMulai");
        print("Jam Akhir $jamSelesai");
        print("Keterangan $keterangan");

        if (dataDecode != null) {
          if (dataDecode['ket'] == "berhasil tambah data") {
            isLoading = false;
            Fluttertoast.showToast(
                msg: "Berhasil Disimpan!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: const Color(0xFF0a4f8f),
                textColor: Colors.white,
                fontSize: 16.0);
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
            msg: "Error : $e",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getKegiatan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: isLoading == false
          ? SizedBox(
              height: 15.h,
              width: 15.w,
              child: FloatingActionButton(
                elevation: 2,
                onPressed: () {
                  setState(() {
                    isLoading == true;
                    _kirim(
                        tglController.text,
                        jamMulai.text,
                        jamSelesai.text,
                        ketController.text,
                        dropdownKegiatan ?? "",
                        fileInBase64);
                  });
                },
                child: Text(
                  "Submit",
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
                      isLoading = false;
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
          "Tambah Log Book",
          style: TextStyle(fontSize: 12.sp),
        ),
        actions: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  galleryImage();
                },
                child: Text(
                  "Pilih Foto",
                  style:
                      TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 2.w,
              ),
              InkWell(
                  onTap: () {
                    cameraImage();
                  },
                  child: Icon(Icons.camera, color: Colors.white, size: 7.w)),
            ],
          ),
          SizedBox(
            width: 3.w,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 3.w, right: 3.w, top: 3.w),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 2.h),
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Pilih Tanggal",
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
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: const Color(0xFF1d8b61)),
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
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      spreadRadius: 0.5,
                                      blurRadius: 2,
                                      offset: const Offset(0, 3),
                                    )
                                  ],
                                ),
                                // child: DropdownButtonHideUnderline(
                                //   child: DropdownButton(
                                //     hint: const Text("Jenis Kegiatan"),
                                //     icon: const Visibility(
                                //         visible: true,
                                //         child: Icon(
                                //             Icons.keyboard_arrow_down_rounded)),
                                //     isExpanded: true,
                                //     items: jenisKegiatan.map((val) {
                                //       return DropdownMenuItem(
                                //         value: val,
                                //         child: Text(val),
                                //       );
                                //     }).toList(),
                                //     value: currentSelectedValue,
                                //     onChanged: (value) {
                                //       setState(() {
                                //         currentSelectedValue = value.toString();
                                //       });
                                //     },
                                //   ),
                                // ),
                                child: Consumer<ProviderRamadhan1445>(
                                  builder: (context, v, child) {
                                    return DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                          value: dropdownKegiatan,
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              dropdownKegiatan = newValue!;
                                            });
                                          },
                                          hint: Text(
                                            "Pilih Kegiatan",
                                            style: TextStyle(fontSize: 11.sp),
                                          ),
                                          icon: const Visibility(
                                              visible: true,
                                              child: Icon(Icons
                                                  .keyboard_arrow_down_rounded)),
                                          isExpanded: true,
                                          items: v.listKegiatan
                                              .map((Kegiatan kegiatan) {
                                            return DropdownMenuItem<String>(
                                                value: kegiatan.id,
                                                child: Text(kegiatan.nama));
                                          }).toList()),
                                    );
                                  },
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
                                padding: const EdgeInsets.all(1),
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
                                              textAlign: TextAlign.center,
                                              onTap: () async {
                                                var date = await showTimePicker(
                                                    context: context,
                                                    initialTime:
                                                        TimeOfDay.now(),
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
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: const Color(0xFF1d8b61),
                                            ),
                                            child: Icon(
                                              Icons.timer_outlined,
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
                                padding: const EdgeInsets.all(1),
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
                                            offset: const Offset(0,
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
                                              textAlign: TextAlign.center,
                                              onTap: () async {
                                                var date = await showTimePicker(
                                                    context: context,
                                                    initialTime:
                                                        TimeOfDay.now(),
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
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: const Color(0xFF1d8b61),
                                            ),
                                            child: Icon(
                                              Icons.timer_off,
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
                      ),
                    ],
                  ),
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
                      padding: const EdgeInsets.all(5),
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
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          )
                        ],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                          child: TextField(
                        controller: ketController,
                        maxLines: 8,
                        style: const TextStyle(),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(fontSize: 11.sp),
                            hintText: "Isi Keterangan"),
                      ))),
                  _image == null
                      ? Container()
                      : Padding(
                          padding: EdgeInsets.only(top: 6.w),
                          child: Column(children: [
                            Center(
                                child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      spreadRadius: 0.5,
                                      blurRadius: 2,
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    )
                                  ],
                                  image: DecorationImage(
                                      image: FileImage(_image!),
                                      fit: BoxFit.cover)),
                              height: 20.h,
                              width: MediaQuery.of(context).size.width,
                            )),
                          ])),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> cameraImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 20);
    if (image != null) {
      setState(() {
        _image = File(image.path);
        List<int> fileInByte = _image!.readAsBytesSync();
        fileInBase64 = 'data:image/png;base64,' + base64Encode(fileInByte);
        print('Foto Kamera : $fileInBase64');
        print("Foto : $_image");
      });
    } else {
      print("No Image selected");
    }
  }

  Future<void> galleryImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 20);
    if (image != null) {
      setState(() {
        _image = File(image.path);
        List<int> fileInByte = _image!.readAsBytesSync();
        fileInBase64 = 'data:image/png;base64,' + base64Encode(fileInByte);
        print('Gambar Galeri : $fileInBase64');
        print("Foto : $_image");
      });
    } else {
      print("Tidak ada gambar yang dipilih");
    }
  }
}