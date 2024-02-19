import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:attedancekaryawanump/views/Auth/login.dart';
import 'package:attedancekaryawanump/views/lembur/lembur.dart';
import 'package:attedancekaryawanump/views/log/log.dart';
import 'package:attedancekaryawanump/views/model/modellogin.dart';
import 'package:attedancekaryawanump/views/pengajian/pengajian.dart';
import 'package:attedancekaryawanump/views/premit/premit.dart';
import 'package:attedancekaryawanump/views/presensi/presensi.dart';
import 'package:attedancekaryawanump/views/provider/providerlogin.dart';
import 'package:attedancekaryawanump/views/ramadhan/1444h/amalia_pages.dart';
import 'package:attedancekaryawanump/views/ramadhan/1444h/presensiramadhan.dart';
import 'package:attedancekaryawanump/views/rekap/rekap.dart';
import 'package:attedancekaryawanump/views/utils/version.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class DashbardKaryawan extends StatefulWidget {
  DashbardKaryawan({Key? key}) : super(key: key);

  @override
  _DashbardKaryawanState createState() => _DashbardKaryawanState();
}

class _DashbardKaryawanState extends State<DashbardKaryawan> {
  String? nama;
  String? username;
  bool? loading = false;
  String version = Version().version;
  String? cekValueVersion;
  cekVersion() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    var url = Uri.parse('https://attendance.ump.ac.id/api/v1/version');
    Map<String, String> head = {
      'Accept': 'application/json',
      'User-Agent': 'neoPresensiAndroid',
      'version': version,
      'X-Authorization': token ?? ""
    };
    var datalogin = await http.get(url, headers: head);
    var dataloginen = datalogin.body;
    var dataDecodeA = jsonDecode(datalogin.body);
    bool status = dataDecodeA['status'];
    int? cekCodeExpired = dataDecodeA['code'];
    print("${cekCodeExpired}");
    if (status == true) {
      setState(() {
        cekValueVersion = "run";
        // print(cekValueVersion);
      });
    } else {
      setState(() {
        cekValueVersion = "no";
        // print(cekValueVersion);
      });
    }
    if (cekCodeExpired == 401) {
      prefs.clear();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Login()),
          (Route<dynamic> route) => false);
    } else if (cekCodeExpired == 411) {
      prefs.clear();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Login()),
          (Route<dynamic> route) => false);
    }
  }

  popUp() {
    // print("oqweipoqwiepiqw${cekValueVersion}");
    if (cekValueVersion == "no") {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              content: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Center(
                    //   child: Container(
                    //     padding: EdgeInsets.all(10),
                    //     margin: EdgeInsets.all(10),
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(5),
                    //         color: Colors.red.shade600),
                    //     child: Text('Aplikasi Udah Usang!!!',
                    //         style: TextStyle(
                    //           fontSize: MediaQuery.of(context).size.width / 20,
                    //           color: Colors.white,
                    //           fontFamily: 'Open Sans',
                    //         )),
                    //   ),
                    // ),
                    Container(
                      height: MediaQuery.of(context).size.height / 3.2,
                      width: MediaQuery.of(context).size.width / 1,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/images/ops.png"))),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 1.h, left: 4.w, right: 4.w, bottom: 1.h),
                      child: Text(
                        "Aplikasi Sudah Usang!!",
                        style: TextStyle(
                            color: Colors.red.shade800,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(left: 4.w, right: 4.w, bottom: 1.h),
                      child: Text(
                        "Segera update aplikasi di Appstore untuk menggunakan aplikasi ini kembali.",
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.black, fontSize: 11.sp),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    // Center(
                    //   child: InkWell(
                    //     child: Container(
                    //       padding: EdgeInsets.all(8),
                    //       margin: EdgeInsets.all(10),
                    //       decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(5),
                    //           color: Colors.teal),
                    //       child: Text('Klik Update',
                    //           style: TextStyle(
                    //             fontSize:
                    //                 MediaQuery.of(context).size.width / 25,
                    //             color: Colors.white,
                    //             fontFamily: 'Open Sans',
                    //           )),
                    //     ),
                    //     onTap: () async {
                    //       // _launchInBrowser(
                    //       //     "https://play.google.com/store/apps/details?id=attedancekaryawanump.ump.ac.id");
                    //       // await LaunchApp.openApp(
                    //       //     androidPackageName: 'com.whatsapp',
                    //       //     iosUrlScheme: 'attedancekaryawanump.ump.ac.id',
                    //       //     appStoreLink:
                    //       //         'https://play.google.com/store/apps/details?id=attedancekaryawanump.ump.ac.id',
                    //       //     openStore: true);
                    //     },
                    //   ),
                    // ),
                    SizedBox(
                      height: 1.h,
                    ),
                  ],
                ),
              ),
            );
          });
    }
  }

  late var timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await cekVersion();
      await _Login();
      _getGeoLocationPosition();
      popUp();
      timer = Timer.periodic(Duration(seconds: 2), (Timer t) {
        CekKoneksi();
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  _Login() async {
    final prefs = await SharedPreferences.getInstance();
    bool? status = prefs.getBool('status');
    String? token = prefs.getString('token');
    String? username = prefs.getString('usernameLogin');
    String? password = prefs.getString('passwordLogin');
    // print(status);
    // print(token);
    // print(username);
    if (status == true) {
      final _providerLogin =
          await Provider.of<ProviderLogin>(context, listen: false);
      await _providerLogin.providerLogin(username, password);

      setState(() {
        loading = _providerLogin.loading;
      });
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Login()),
          (Route<dynamic> route) => false);
    }
    // print("jksadbjbasd${loading}");
  }

  // Future<void> _launchInBrowser(String url) async {
  //   if (!await launch(
  //     url,
  //     forceSafariVC: false,
  //     forceWebView: false,
  //     headers: <String, String>{'my_header_key': 'my_header_value'},
  //   )) {
  //     throw 'Could not launch $url';
  //   }
  // }

  bool? koneksi = true;
  CekKoneksi() async {
    try {
      final result = await InternetAddress.lookup('www.google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        setState(() {
          koneksi = true;
        });
      }
    } on SocketException catch (_) {
      print('not connected');
      setState(() {
        koneksi = false;
      });
    }
  }

  getdevice() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    print('Running on ${androidInfo.device}');
  }

  @override
  Widget build(BuildContext context) {
    ModelLogin? data = Provider.of<ProviderLogin>(context, listen: true).data;
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      body: RefreshIndicator(
        onRefresh: () async {
          cekVersion();
          CekKoneksi();
          _Login();
        },
        color: const Color(0xFF0a4f8f),
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Positioned(
                  top: 0.h,
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(13),
                          bottomRight: Radius.circular(13)),
                      color: Color(0xFF0a4f8f),
                    ),
                    height: 27.h,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        widgeticons(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(left: 0.w),
                                child: loading == true
                                    ? Container(
                                        width: 13.w,
                                        height: 8.h,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/profile.png'),
                                            fit: BoxFit.contain,
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                      )
                                    : Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        child: Container(
                                          width: 13.w,
                                          height: 8.h,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )),
                            loading == true
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 3.w),
                                        child: SizedBox(
                                          width: 70.w,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Selamat Datang,',
                                                style: TextStyle(
                                                    fontSize: 10.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white70),
                                              ),
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              Text(data?.data?.nama ?? "",
                                                  style: TextStyle(
                                                      fontSize: 13.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white))
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 3.w),
                                        child: SizedBox(
                                          width: 70.w,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 30.w,
                                                height: 2.3.h,
                                                child: Shimmer.fromColors(
                                                  baseColor:
                                                      Colors.grey.shade300,
                                                  highlightColor:
                                                      Colors.grey.shade100,
                                                  child: Container(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              SizedBox(
                                                width: 50.w,
                                                height: 2.7.h,
                                                child: Shimmer.fromColors(
                                                  baseColor:
                                                      Colors.grey.shade300,
                                                  highlightColor:
                                                      Colors.grey.shade100,
                                                  child: Container(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 32.h,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    color: const Color(0xFFF4F4F4),
                    padding: EdgeInsets.only(left: 5.w, right: 5.w),
                    child: Column(
                      children: [
                        widgetaplikasi(),
                        loading == true ? widgeImages() : widgeImagesLoading()
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 22.h,
                  left: 5.w,
                  right: 5.w,
                  child: Center(
                    child: Container(
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: loading == true
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 4.w),
                                        child: Text(
                                          'Unit Kerja',
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xFF0a4f8f),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 4.w),
                                        child: Text(
                                          // data ??
                                          "-",
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 7.w),
                                    child: Center(
                                      // child: profile.when(
                                      //     data: (data) =>
                                      child: Text(data?.data?.username ?? "",
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xFF0a4f8f),
                                          )),
                                    ),
                                  )
                                ],
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 4.w),
                                        child: SizedBox(
                                          width: 22.w,
                                          height: 2.3.h,
                                          child: Shimmer.fromColors(
                                            baseColor: Colors.grey.shade300,
                                            highlightColor:
                                                Colors.grey.shade100,
                                            child: Container(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 4.w),
                                        child: SizedBox(
                                          width: 30.w,
                                          height: 2.3.h,
                                          child: Shimmer.fromColors(
                                            baseColor: Colors.grey.shade300,
                                            highlightColor:
                                                Colors.grey.shade100,
                                            child: Container(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 7.w),
                                    child: Center(
                                      child: SizedBox(
                                        width: 30.w,
                                        height: 2.3.h,
                                        child: Shimmer.fromColors(
                                          baseColor: Colors.grey.shade300,
                                          highlightColor: Colors.grey.shade100,
                                          child: Container(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )),
                  ),
                ),
                koneksi == false
                    ? Positioned(
                        child: Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(15)),
                                margin: EdgeInsets.symmetric(
                                    vertical: 4.5.h, horizontal: 3.w),
                                padding: EdgeInsets.symmetric(
                                    vertical: 1.h, horizontal: 8.w),
                                child: Text(
                                  'Tidak Ada Koneksi',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10.sp),
                                ))))
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget widgeticons() {
    return Padding(
      padding: EdgeInsets.only(left: 2.w, bottom: 1.h),
      child: Row(children: [
        Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Colors.white,
          size: 2.0.h,
        ),
        Text(
          ' Back',
          style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
      ]),
    );
  }

  Widget widgeImagesLoading() {
    return Padding(
      padding: EdgeInsets.only(top: 3.w),
      child: Container(
        height: 20.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11),
        ),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget widgeImages() {
    return Padding(
      padding: EdgeInsets.only(top: 3.w),
      child: Container(
        height: 20.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11),
            image: const DecorationImage(
                image: AssetImage('assets/images/pmb.jpg'), fit: BoxFit.cover)),
      ),
    );
  }

  Widget menuView() {
    return Padding(
      padding: EdgeInsets.only(top: 2.4.h, left: 3.w, right: 3.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: _menu(
                icon: Icons.camera,
                color: Colors.cyan,
                text: 'Presensi',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Presensi()),
                  );
                }),
          ),
          Expanded(
            flex: 2,
            child: _menu(
                icon: Icons.book,
                // color: Colors.amber,
                color: Colors.indigo.shade400,
                text: 'Rekap',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Rekap()),
                  );
                }),
          ),
          Expanded(
            flex: 2,
            child: _menu(
                icon: Icons.add_alarm_rounded,
                color: Colors.orange,
                text: 'Perizinan',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Premit()),
                  );
                }),
          ),
          Expanded(
            flex: 2,
            child: _menu(
                icon: Icons.query_builder_sharp,
                color: Color(0xFFFE6646),
                text: 'Lembur',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Lembur()),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Widget menuView2() {
    return Padding(
      padding: EdgeInsets.only(top: 2.4.h, left: 3.w, right: 3.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: _menu(
                icon: Icons.menu_book_sharp,
                // color: Color(0xFFF5ACFC9),
                color: Colors.amber,
                text: 'Logbook',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Log()),
                  );
                }),
          ),
          Expanded(
            flex: 2,
            child: _menu(
                icon: Icons.manage_search_rounded,
                color: Colors.cyan,
                text: 'Pengajian',
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Pengajian()),
                  );
                }),
          ),
          Expanded(
            flex: 2,
            child: _menu(
                icon: Icons.mosque,
                // color: Color(0xFFF5ACFC9),
                color: Colors.green,
                text: 'Ramadhan',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AmaliaPages()),
                  );
                }),
          ),
          Expanded(
              flex: 2,
              child: _menu(
                  icon: Icons.question_mark_outlined,
                  color: Colors.orange,
                  text: 'Incoming',
                  onTap: () {
                    // _launchInBrowser("https://simpeg.ump.ac.id/config/index.php");
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => DaftarKelompok()),
                    // );
                  })),
        ],
      ),
    );
  }

  // Widget menuView2() {
  //   return Padding(
  //     padding: EdgeInsets.only(top: 3.h, left: 3.w, right: 3.w),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         _menu(
  //             icon: Icons.menu_book_sharp,
  //             // color: Color(0xFFF5ACFC9),
  //             color: Colors.amber,
  //             text: 'Logbook',
  //             onTap: () {
  //               Navigator.push(
  //                 context,
  //                 MaterialPageRoute(builder: (context) => Log()),
  //               );
  //             }),
  //         _menu(
  //             icon: Icons.manage_search_rounded,
  //             color: Colors.cyan,
  //             text: 'Pengajian',
  //             onTap: () async {
  //               Navigator.push(
  //                 context,
  //                 MaterialPageRoute(builder: (context) => Pengajian()),
  //               );
  //             }),
  //         _menu(
  //             icon: Icons.mosque,
  //             // color: Color(0xFFF5ACFC9),
  //             color: Colors.green,
  //             text: 'Amalia',
  //             onTap: () {
  //               Navigator.push(
  //                 context,
  //                 MaterialPageRoute(builder: (context) => AmaliaPages()),
  //               );
  //             }),
  //         _menu(
  //             icon: Icons.local_post_office,
  //             color: Color(0xFFFE6646),
  //             text: 'E-Surat',
  //             onTap: () {
  //               _launchInBrowser("https://e-surat.ump.ac.id/login/");
  //               // Navigator.push(
  //               //   context,
  //               //   MaterialPageRoute(builder: (context) => DaftarKelompok()),
  //               // );
  //             }),
  //         // _menu(
  //         //     icon: Icons.more_horiz,
  //         //     color: Colors.orange,
  //         //     text: 'Lainnya',
  //         //     onTap: () {
  //         //       showModalBottomSheet(
  //         //         context: context,
  //         //         builder: (context) {
  //         //           return AspectRatio(
  //         //             aspectRatio: 16 / 12,
  //         //             child: Container(
  //         //               width: double.infinity,
  //         //               height: double.infinity,
  //         //               child: Column(
  //         //                 mainAxisAlignment: MainAxisAlignment.start,
  //         //                 crossAxisAlignment: CrossAxisAlignment.start,
  //         //                 children: [
  //         //                   SizedBox(
  //         //                     height: 20,
  //         //                   ),
  //         //                   Container(
  //         //                     margin: EdgeInsets.only(left: 10),
  //         //                     padding: EdgeInsets.only(
  //         //                         top: 7, bottom: 7, right: 20, left: 20),
  //         //                     decoration: BoxDecoration(
  //         //                         color: Color(0xFF0a4f8f),
  //         //                         borderRadius: BorderRadius.only(
  //         //                             bottomRight: Radius.circular(15),
  //         //                             topRight: Radius.circular(15))),
  //         //                     child: Text(
  //         //                       'Lainnya',
  //         //                       style: TextStyle(
  //         //                           color: Colors.white,
  //         //                           fontSize: 10.sp,
  //         //                           fontWeight: FontWeight.bold),
  //         //                     ),
  //         //                   ),
  //         //                   Padding(
  //         //                     padding: EdgeInsets.only(
  //         //                         top: 3.h, left: 3.w, right: 3.w),
  //         //                     child: Row(
  //         //                       mainAxisAlignment: MainAxisAlignment.start,
  //         //                       crossAxisAlignment: CrossAxisAlignment.center,
  //         //                       children: [
  //         //                         _menu(
  //         //                             icon: Icons.account_circle,
  //         //                             color: Colors.blue,
  //         //                             text: 'Simpeg',
  //         //                             onTap: () async {
  //         //                               // await LaunchApp.openApp(
  //         //                               //   androidPackageName: 'app.smartoffice.ac.id',
  //         //                               //   iosUrlScheme: 'app.smartoffice.ac.id',
  //         //                               //   // appStoreLink:
  //         //                               //   //     'itms-apps://itunes.apple.com/us/app/pulse-secure/id945832041',
  //         //                               //   // openStore: false
  //         //                               // );

  //         //                               Navigator.push(
  //         //                                 context,
  //         //                                 MaterialPageRoute(
  //         //                                     builder: (context) =>
  //         //                                         Pengajian()),
  //         //                               );
  //         //                             }),
  //         //                         SizedBox(
  //         //                           width: 20,
  //         //                         ),
  //         //                         _menu(
  //         //                             icon: Icons.mosque,
  //         //                             // color: Color(0xFFF5ACFC9),
  //         //                             color: Colors.green,
  //         //                             text: 'Amalia',
  //         //                             onTap: () {
  //         //                               Navigator.push(
  //         //                                 context,
  //         //                                 MaterialPageRoute(
  //         //                                     builder: (context) => Log()),
  //         //                               );
  //         //                             }),
  //         //                       ],
  //         //                     ),
  //         //                   )
  //         //                 ],
  //         //               ),
  //         //             ),
  //         //           );
  //         //         },
  //         //       );
  //         //       _launchInBrowser("https://e-surat.ump.ac.id/login/");
  //         //       Navigator.push(
  //         //         context,
  //         //         MaterialPageRoute(builder: (context) => DaftarKelompok()),
  //         //       );
  //         //     }),
  //       ],
  //     ),
  //   );
  // }

  // Widget menuView3() {
  //   return Padding(
  //     padding: EdgeInsets.only(top: 3.h, left: 3.w, right: 3.w),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         Expanded(
  //           flex: 2,
  //           child: _menu(
  //               icon: Icons.account_circle,
  //               // color: Color(0xFFF5ACFC9),
  //               color: Colors.indigo.shade400,
  //               text: 'Simpeg',
  //               onTap: () {
  //                 _launchInBrowser("https://simpeg.ump.ac.id/config/index.php");
  //               }),
  //         ),
  //         Expanded(
  //           flex: 2,
  //           child: _menu(
  //               icon: Icons.assessment,
  //               color: Colors.amber,
  //               text: 'Simaset',
  //               onTap: () async {
  //                 // await LaunchApp.openApp(
  //                 //   androidPackageName: 'app.smartoffice.ac.id',
  //                 //   iosUrlScheme: 'app.smartoffice.ac.id',
  //                 //   // appStoreLink:
  //                 //   //     'itms-apps://itunes.apple.com/us/app/pulse-secure/id945832041',
  //                 //   // openStore: false
  //                 // );
  //                 _launchInBrowser("https://simaset.ump.ac.id/");
  //               }),
  //         ),
  //         Expanded(
  //           flex: 2,
  //           child: _menu(
  //               icon: Icons.shopping_bag_outlined,
  //               // color: Color(0xFFFE6646),
  //               color: Colors.green,
  //               text: 'Umplaza',
  //               onTap: () {
  //                 _launchInBrowser("https://umplaza.id/");
  //                 // Navigator.push(
  //                 //   context,
  //                 //   MaterialPageRoute(builder: (context) => DaftarKelompok()),
  //                 // );
  //               }),
  //         ),
  //         Expanded(
  //           flex: 2,
  //           child: _menu(
  //               icon: Icons.receipt_outlined,
  //               color: Colors.orange,
  //               text: 'Sijaru',
  //               onTap: () {
  //                 // showModalBottomSheet(
  //                 //   context: context,
  //                 //   builder: (context) {
  //                 //     return AspectRatio(
  //                 //       aspectRatio: 16 / 12,
  //                 //       child: Container(
  //                 //         width: double.infinity,
  //                 //         height: double.infinity,
  //                 //         child: Column(
  //                 //           mainAxisAlignment: MainAxisAlignment.start,
  //                 //           crossAxisAlignment: CrossAxisAlignment.start,
  //                 //           children: [
  //                 //             SizedBox(
  //                 //               height: 20,
  //                 //             ),
  //                 //             Container(
  //                 //               margin: EdgeInsets.only(left: 10),
  //                 //               padding: EdgeInsets.only(
  //                 //                   top: 7, bottom: 7, right: 20, left: 20),
  //                 //               decoration: BoxDecoration(
  //                 //                   color: Color(0xFF0a4f8f),
  //                 //                   borderRadius: BorderRadius.only(
  //                 //                       bottomRight: Radius.circular(15),
  //                 //                       topRight: Radius.circular(15))),
  //                 //               child: Text(
  //                 //                 'Lainnya',
  //                 //                 style: TextStyle(
  //                 //                     color: Colors.white,
  //                 //                     fontSize: 10.sp,
  //                 //                     fontWeight: FontWeight.bold),
  //                 //               ),
  //                 //             ),
  //                 //             Padding(
  //                 //               padding: EdgeInsets.only(
  //                 //                   top: 3.h, left: 3.w, right: 3.w),
  //                 //               child: Row(
  //                 //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 //                 children: [
  //                 //                   _menu(
  //                 //                       icon: Icons.account_circle,
  //                 //                       color: Colors.blue,
  //                 //                       text: 'Simpeg',
  //                 //                       onTap: () async {
  //                 //                         // await LaunchApp.openApp(
  //                 //                         //   androidPackageName: 'app.smartoffice.ac.id',
  //                 //                         //   iosUrlScheme: 'app.smartoffice.ac.id',
  //                 //                         //   // appStoreLink:
  //                 //                         //   //     'itms-apps://itunes.apple.com/us/app/pulse-secure/id945832041',
  //                 //                         //   // openStore: false
  //                 //                         // );

  //                 //                         Navigator.push(
  //                 //                           context,
  //                 //                           MaterialPageRoute(
  //                 //                               builder: (context) =>
  //                 //                                   Pengajian()),
  //                 //                         );
  //                 //                       }),
  //                 //                   SizedBox(
  //                 //                     width: 20,
  //                 //                   ),
  //                 //                   _menu(
  //                 //                       icon: Icons.mosque,
  //                 //                       // color: Color(0xFFF5ACFC9),
  //                 //                       color: Colors.green,
  //                 //                       text: 'Amalia',
  //                 //                       onTap: () {
  //                 //                         Navigator.push(
  //                 //                           context,
  //                 //                           MaterialPageRoute(
  //                 //                               builder: (context) => Log()),
  //                 //                         );
  //                 //                       }),
  //                 //                 ],
  //                 //               ),
  //                 //             )
  //                 //           ],
  //                 //         ),
  //                 //       ),
  //                 //     );
  //                 //   },
  //                 // );
  //                 _launchInBrowser("https://sijaru.ump.ac.id/");
  //                 // Navigator.push(
  //                 //   context,
  //                 //   MaterialPageRoute(builder: (context) => DaftarKelompok()),
  //                 // );
  //               }),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget menuLoading() {
    return Padding(
      padding: EdgeInsets.only(top: 2.4.h, left: 3.w, right: 3.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _menuLoading(
            icon: Icons.camera,
            color: Colors.cyan,
            text: 'Presensi',
          ),
          _menuLoading(
            icon: Icons.book,
            color: Colors.amber,
            text: 'Rekap',
          ),
          _menuLoading(
            icon: Icons.add_alarm_rounded,
            color: Colors.orange,
            text: 'Perizinan',
          ),
          _menuLoading(
            icon: Icons.query_builder_sharp,
            color: Color(0xFFFE6646),
            text: 'Lembur',
          ),
        ],
      ),
    );
  }

  Widget _menu(
      {required IconData icon,
      required String text,
      required Color color,
      required VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
          padding:
              EdgeInsets.only(left: 1.w, right: 1.w, top: 1.w, bottom: 1.w),
          decoration: BoxDecoration(
            // color: Colors.amber,
            borderRadius: BorderRadius.circular(4),
            // border: Border.all(color: Colors.black)
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration:
                      BoxDecoration(color: color, shape: BoxShape.circle),
                  child: Padding(
                    padding: EdgeInsets.all(5.sp),
                    child: Icon(
                      icon,
                      color: Colors.white,
                      size: 23.sp,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 1.h),
                  child: Text(
                    text,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 9.sp),
                  ),
                )
              ],
            ),
          )),
    );
  }

  Widget _menuLoading(
      {required IconData icon,
      required String text,
      required Color color,
      VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
          padding: EdgeInsets.only(left: 3.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            // border: Border.all(color: Colors.black)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  width: 13.w,
                  height: 8.h,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 1.h),
                child: SizedBox(
                  width: 10.w,
                  height: 2.h,
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }

  Widget widgetaplikasi() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding:
              EdgeInsets.only(left: 0.w, right: 0.w, top: 1.7.h, bottom: 4.5.h),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                loading == true
                    ? Container(
                        padding: EdgeInsets.only(
                            top: 7, bottom: 7, right: 20, left: 20),
                        decoration: BoxDecoration(
                            color: Color(0xFF0a4f8f),
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(15),
                                topRight: Radius.circular(15))),
                        child: Text(
                          'Menu',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    : Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          width: 18.w,
                          height: 2.2.h,
                          padding: EdgeInsets.only(
                              top: 7, bottom: 7, right: 20, left: 20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(15),
                                  topRight: Radius.circular(15))),
                        )),
                loading == true ? menuView() : menuLoading(),
                loading == true ? menuView2() : menuLoading(),
                // loading == true ? menuView3() : menuLoading(),
              ]),
        ),
      ),
    );
  }
}

class MenuAplikasi extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const MenuAplikasi(
      {required this.text,
      required this.icon,
      required this.color,
      this.onTap});

  final String text;
  final Icon icon;
  final Color color;
  final VoidCallback? onTap;

  @override
  _MenuAplikasiState createState() => _MenuAplikasiState();
}

class _MenuAplikasiState extends State<MenuAplikasi> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: EdgeInsets.only(top: 2.h),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: 10.h,
                  height: 10.h,
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(color: Colors.black38, blurRadius: 1)
                      ],
                      color: widget.color,
                      borderRadius: BorderRadius.circular(20)),
                  child: widget.icon),
              SizedBox(
                height: 2.h,
              ),
              Center(
                child: Text(
                  widget.text,
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 9.sp,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
