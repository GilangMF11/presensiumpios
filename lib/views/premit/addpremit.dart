import 'dart:convert';
import 'dart:io';
import 'package:attedancekaryawanump/views/premit/premit.dart';
import 'package:attedancekaryawanump/views/utils/version.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class AddPremit extends StatefulWidget {
  const AddPremit({Key? key}) : super(key: key);

  @override
  State<AddPremit> createState() => _AddPremitState();
}

class _AddPremitState extends State<AddPremit> {
  bool isLoading = false;
  List _studentList = ["Sakit", "Ijin", "Dinas Luar", "Cuti", "Izin Belajar"];
  String? _currentSelectedItem;
  final deskripsicontroller = TextEditingController();
  final dateControllermulai = TextEditingController();
  final dateControllerakhir = TextEditingController();
  File? _image;
  final ImagePicker _picker = ImagePicker();
  String? fileInBase64;
  SharedPreferences? sharedPreferences;
  String version = Version().version;

  _krim(String? dateawal, String? dateakhir, String tipee, String reason,
      String? filee) async {
    // print("${dateawal} ashvjavd");
    if (dateawal == "") {
      setState(() {
        isLoading = false;
        Fluttertoast.showToast(
            msg: "Date awal belum diisi",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      });
    } else if (dateakhir == "") {
      setState(() {
        isLoading = false;
        Fluttertoast.showToast(
            msg: "Date akhir belum diisi",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      });
    } else if (tipee == "") {
      setState(() {
        isLoading = false;
        Fluttertoast.showToast(
            msg: "Tipe belum diisi",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      });
    } else if (reason == "") {
      setState(() {
        isLoading = false;
        Fluttertoast.showToast(
            msg: "Alasan belum diisi",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      });
    } else if (filee == null) {
      setState(() {
        isLoading = false;
        Fluttertoast.showToast(
            msg: "Foto belum diisi",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      });
    }
    var url = Uri.parse('https://attendance.ump.ac.id/api/v1/permit');
    sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences?.getString('token');
    // print(fileInBase64);
    String? a;
    if (tipee == "Sakit") {
      setState(() {
        a = "1";
      });
    } else if (tipee == "Ijin") {
      setState(() {
        a = "2";
      });
    } else if (tipee == "Dinas Luar") {
      setState(() {
        a = "3";
      });
    } else if (tipee == "Cuti") {
      setState(() {
        a = "4";
      });
    } else if (tipee == "Izin Belajar") {
      setState(() {
        a = "5";
      });
    }

    // print(dateawal);
    // print(dateakhir);
    // print(a);
    // print(reason);
    // print(filee);
    Map data = {
      "start": dateawal,
      "end": dateakhir,
      "type": a,
      "reason": reason,
      "file": filee
    };
    Map<String, String> head = {
      'Accept': 'application/json',
      'User-Agent': 'neoPresensiAndroid',
      'X-Authorization': token!,
      'version': version
    };
    var datalogin = await http.post(url, headers: head, body: data);
    var dataloginen = datalogin.body;
    var dataDecode = jsonDecode(datalogin.body);
    print(dataDecode);
    // bool stat = dataDecode['status'];
    String statRed = dataDecode['message'];
    if (statRed == 'OK') {
      setState(() {
        isLoading = false;
        Navigator.of(context).pop();
        Fluttertoast.showToast(
            msg: statRed,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: const Color(0xFF0a4f8f),
            textColor: Colors.white,
            fontSize: 16.0);
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => Premit()),
        // );
      });
    } else {
      setState(() {
        isLoading = false;
        Fluttertoast.showToast(
            msg: statRed,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      });
    }
    // var status = dataloginen['status'];
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
                  isLoading = true;
                  _krim(
                      dateControllermulai.text,
                      dateControllerakhir.text,
                      _currentSelectedItem ?? "",
                      deskripsicontroller.text,
                      fileInBase64);

                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => AddPremit()),
                  // );
                },
                child: Text("Submit", style: TextStyle(fontSize: 10.sp)),
                backgroundColor: Color.fromARGB(255, 223, 84, 56),
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
                      // _kirim(currentSelectedValue.toString());
                    });
                  },
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.grey),
            ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF0a4f8f),
        title: Text(
          'Tambah Perizinan',
          style: TextStyle(fontSize: 12.sp),
        ),
        actions: [
          InkWell(
              onTap: () {
                _showChoiceDialog(context);
              },
              child: Center(
                  child:
                      Text('Pilih Foto', style: TextStyle(fontSize: 12.sp)))),
          SizedBox(width: 1.w),
          InkWell(
            onTap: () {
              _showChoiceDialog(context);
            },
            child: Icon(
              Icons.camera,
              color: Colors.white,
              size: 7.w,
            ),
          ),
          SizedBox(width: 4.w)
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
                      Row(
                        children: [
                          Text(
                            'Alasan',
                            style: TextStyle(fontSize: 12.sp),
                          ),
                          Text(
                            '*',
                            style:
                                TextStyle(fontSize: 12.sp, color: Colors.red),
                          ),
                        ],
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
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              )
                            ],
                          ),
                          child: Row(children: <Widget>[
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.orange),
                              child: Icon(
                                Icons.access_alarm_rounded,
                                color: Colors.white,
                                size: 6.w,
                              ),
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            Expanded(
                              flex: 1,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  hint: Text(
                                    "Pilih Alasan",
                                    style: TextStyle(fontSize: 11.sp),
                                  ),
                                  icon: Visibility(
                                      visible: true,
                                      child: Icon(
                                          Icons.keyboard_arrow_down_rounded)),
                                  isExpanded: true,
                                  items: _studentList.map((val) {
                                    return DropdownMenuItem(
                                      value: val,
                                      child: Text(val),
                                    );
                                  }).toList(),
                                  value: _currentSelectedItem,
                                  onChanged: (value) {
                                    setState(() {
                                      _currentSelectedItem = value.toString();
                                    });
                                  },
                                ),
                              ),
                            )
                          ])),
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
                                              controller: dateControllermulai,
                                              decoration: InputDecoration(
                                                hintStyle:
                                                    TextStyle(fontSize: 11.sp),
                                                hintText: 'Tanggal Mulai',
                                                border: InputBorder.none,
                                              ),
                                              onTap: () async {
                                                var date = await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(1900),
                                                    lastDate: DateTime(2100));
                                                dateControllermulai.text = date
                                                    .toString()
                                                    .substring(0, 10);
                                                // print(dateControllermulai.text);
                                              },
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
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
                                              controller: dateControllerakhir,
                                              decoration: InputDecoration(
                                                hintStyle:
                                                    TextStyle(fontSize: 11.sp),
                                                hintText: 'Tanggal Akhir',
                                                border: InputBorder.none,
                                              ),
                                              onTap: () async {
                                                var date = await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(1900),
                                                    lastDate: DateTime(2100));
                                                dateControllerakhir.text = date
                                                    .toString()
                                                    .substring(0, 10);
                                                // print(dateControllerakhir.text);
                                              },
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Color(0xFF000000)),
                                            child: Icon(
                                              Icons.calendar_month,
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
                        controller: deskripsicontroller,
                        maxLines: 8,
                        style: TextStyle(),
                        decoration: InputDecoration(
                            hintStyle: TextStyle(fontSize: 11.sp),
                            border: InputBorder.none,
                            hintText: "Isi Keterangan"),
                      ))),
                  SizedBox(
                    height: 3.h,
                  ),
                  _image == null
                      ? Container()
                      : Padding(
                          padding: EdgeInsets.all(0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Foto',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Container(
                                  child: Center(
                                      child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.1),
                                            spreadRadius: 0.5,
                                            blurRadius: 2,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          )
                                        ],
                                        image: DecorationImage(
                                            image: FileImage(_image!),
                                            fit: BoxFit.cover)),
                                    height: 20.h,
                                    width: MediaQuery.of(context).size.width,
                                  )),
                                ),
                              ])),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future cameraImage() async {
    final ImagePicker _picker = ImagePicker();
    final image =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    setState(() {
      if (image != null) {
        _image = File(image.path);
        // String fileName = _image!.path.split('/').last;
        // print('opopo : $fileName');
        // print('File is = ' + _image.toString());
        List<int> fileInByte = _image!.readAsBytesSync();
        fileInBase64 = base64Encode(fileInByte);
        // print('asd : $fileInBase64');
      } else {
        // print("No Image selected");
      }
    });
  }

  Future galleryImage() async {
    final ImagePicker _picker = ImagePicker();
    final image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      if (image != null) {
        _image = File(image.path);
        // print('File is = ' + _image.toString());
        List<int> fileInByte = _image!.readAsBytesSync();
        fileInBase64 = base64Encode(fileInByte);
        // print('asd : $fileInBase64');
        // print('asd : $_image');
      } else {
        // print("No Image selected");
      }
    });
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Choose option",
              style: TextStyle(color: Colors.blue),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      galleryImage();
                    },
                    title: Text("Gallery"),
                    leading: Icon(
                      Icons.account_box,
                      color: Colors.blue,
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      cameraImage();
                    },
                    title: Text("Camera"),
                    leading: Icon(
                      Icons.camera,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
