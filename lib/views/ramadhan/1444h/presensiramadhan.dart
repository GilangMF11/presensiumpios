import 'package:attedancekaryawanump/views/model/modelpengajian.dart';
import 'package:attedancekaryawanump/views/provider/ramadhan/1444h/provideralquran.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'dart:math' show sin, cos, sqrt, atan2;
import 'package:vector_math/vector_math.dart' as math;

class PresensiRamadhan extends StatefulWidget {
  String? materi_id;
  String? kegiatan;
  String? tanggale;
  String? dari_jam;
  String? sampai_jam;
  String? pemateri;
  String? keterangan;
  String? radius_id;
  String? tempat;
  String? lat;
  String? long;
  String? radius;
  String? hikmah;
  PresensiRamadhan(
      {this.materi_id,
      this.kegiatan,
      this.tanggale,
      this.dari_jam,
      this.sampai_jam,
      this.pemateri,
      this.keterangan,
      this.radius_id,
      this.tempat,
      this.lat,
      this.long,
      this.radius,
      this.hikmah});

  @override
  State<PresensiRamadhan> createState() => _PresensiRamadhanState();
}

class _PresensiRamadhanState extends State<PresensiRamadhan> {
  TextEditingController hikmahController = TextEditingController();
  // bool? loading = true;
  bool? _isLoading = false;
  bool _isLoadingLocation = false;
  String? _latitude;
  String? _longitude;
  bool? _isMockLocation;

  // var currentSelectedValuekampus;
  String? hasilid;
  // String? tema;
  // int? radius;
  String location = 'Null, Press Button';
  double earthRadius = 6371000;
  String Address = 'Lokasi Belum di Ketahui!!';
  String statusrad = 'Belum';
  var lo;
  var la;
  var jarakradius;

  // Future<void> getLocationAA() async {
  //   try {
  //     TrustLocation.onChange.listen((values) => setState(() {
  //           _latitude = values.latitude;
  //           _longitude = values.longitude;
  //           _isMockLocation = values.isMockLocation;
  //           print("mock up${_isMockLocation}");
  //         }));
  //   } on PlatformException catch (e) {
  //     print('PlatformException $e');
  //   }
  // }

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
      // if (currentSelectedValuekampus != null) {
      setState(() {
        _isLoading = false;
        _isLoadingLocation = false;
        Fluttertoast.showToast(
            msg: "Izinkan GPS permision untuk menggunakan aplikasi ini",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      });
      // } else {
      // setState(() {
      //   _isLoading = false;
      //   _isLoadingLocation = false;
      // });
      // }

      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  // double pLat = -7.413241;
  // double pLng = 109.272966;

  //Kampus Pusat
  // double? pLat;
  // double? pLng;

  getDistance() async {
    print(double.parse(widget.lat!));
    print(double.parse(widget.long!));
    print(widget.radius);
    // if (currentSelectedValuekampus == null) {
    //   Position position = await _getGeoLocationPosition();
    //   setState(() {
    //     _isLoadingLocation = false;
    //     _isLoading = false;
    //   });
    //   Fluttertoast.showToast(
    //       msg: "Set Lokasi Kampus Sebelumnya",
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.CENTER,
    //       timeInSecForIosWeb: 1,
    //       backgroundColor: Colors.red,
    //       textColor: Colors.white,
    //       fontSize: 16.0);
    // } else
    // if (currentSelectedValuekampus != null) {

    Position position = await _getGeoLocationPosition();
    var dLat = math.radians(double.parse(widget.lat!) - position.latitude);
    var dLng = math.radians(double.parse(widget.long!) - position.longitude);
    print("lat${position.latitude}");
    print("lat${position.longitude}");
    //Add Address
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];

    //Rumus Radius Jarak
    var a = sin(dLat / 2) * sin(dLat / 2) +
        cos(math.radians(position.latitude)) *
            cos(math.radians(double.parse(widget.lat!))) *
            sin(dLng / 2) *
            sin(dLng / 2);
    var c = 2 * atan2(sqrt(a), sqrt(1 - a));
    var d = earthRadius * c;

    //set long & lat
    lo = position.latitude;
    la = position.longitude;
    setState(() {
      location = "$lo $la";
      jarakradius = d;
    });

    print(jarakradius); //d is the distance in meters

    print("haloo yaa ${widget.radius!}");
    if (d < int.parse(widget.radius!)) {
      setState(() {
        _isLoading = false;
        _isLoadingLocation = false;
        Address =
            '${place.street}, ${place.subLocality}, ${place.locality}, ${place.country}';
        if (_isMockLocation == false) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: const Color(0xFF1d8b61),
            content: Text("Anda Dalam Radius Kantor"),
          ));
        } else if (_isMockLocation == true) {
          Fluttertoast.showToast(
              msg: "Anda Terdeteksi Memakai Fake GPS.",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
        print('Masuk Kampus 1');
        statusrad = 'masuk';
      });
    } else {
      setState(() {
        _isLoading = false;
        _isLoadingLocation = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text("Anda Berada Diluar Radius Kantor!!"),
        ));
        print('Gagal');
        statusrad = 'gagal';
      });
    }
    // }
  }

  // getPegajian() async {
  //   final providerrekap = Provider.of<ProviderAlQuran>(context, listen: false);
  //   await providerrekap.getPengajian();
  //   setState(() {
  //     tema = providerrekap.getpre?.first.temaPengajian;
  //     loading = providerrekap.loading;
  //   });
  // }

  // getlistPegajian() async {
  //   final providerrekap =
  //       Provider.of<ProviderPengajian>(context, listen: false);
  //   await providerrekap.getnamPengajian();
  //   setState(() {
  //     loading = providerrekap.loading;
  //   });
  // }

  _kirim(String? hikmah) async {
    if (hikmah == '') {
      setState(() {
        _isLoading = false;
      });
      Fluttertoast.showToast(
          msg: "Hikmah tidak boleh kosong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (Address == 'Lokasi Belum di Ketahui!!') {
      setState(() {
        _isLoading = false;
        Fluttertoast.showToast(
            msg: "Lokasi tidak boleh kosong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      });
    } else if (statusrad == 'gagal') {
      setState(() {
        _isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text("Diluar Radius Presensi!!"),
        ));
      });
    } else if (statusrad == 'belum') {
      setState(() {
        _isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text("Diluar Radius Presensi!!")));
      });
    } else if (statusrad == 'masuk') {
      final _providerPresensi =
          Provider.of<ProviderAlQuran>(context, listen: false);
      await _providerPresensi.kirimPresensiPengajian(hikmahController.text);
      String? status = _providerPresensi.presensistatus;
      if (status == "berhasil") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: const Color(0xFF1d8b61),
            content: Text("Persensi Berhasil")));
        int count = 0;
        Navigator.of(context).popUntil((_) => count++ >= 2);
        setState(() {
          _isLoading = _providerPresensi.loadingkirimpresensi;
        });
      } else if (status == "gagal") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red, content: Text("Presensi Gagal")));
        setState(() {
          _isLoading = _providerPresensi.loadingkirimpresensi;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red, content: Text("Presensi Gagal")));
        setState(() {
          _isLoading = _providerPresensi.loadingkirimpresensi;
        });
      }
    }
  }

  // String? materi_id;
  // String? kegiatan;
  // String? tanggale;
  // String? dari_jam;
  // String? sampai_jam;
  // String? pemateri;
  // String? keterangan;
  // String? radius_id;
  // String? tempat;
  // String? hikmah;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // radius = int.parse(widget.radius!);
      // pLat = double.parse(widget.lat!);
      // pLng = double.parse(widget.lat!);
      // TrustLocation.start(1);
      // getLocationAA();
      hikmahController = TextEditingController()..text = "${widget.hikmah}";
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ModelPengajianGet? listData =
    //     Provider.of<ProviderPengajian>(context, listen: true).dataPengajian;
    // List<ResponsePengajian>? namMasjid =
    //     Provider.of<ProviderPengajian>(context, listen: true).listNamaKegiatan;
    // print("datanya adalah ${namMasjid?.length}");
    return Consumer<ProviderAlQuran>(builder: (context, v, child) {
      return Scaffold(
          floatingActionButton: _isLoading == false
              ? SizedBox(
                  height: 15.h,
                  width: 15.w,
                  child: FloatingActionButton(
                    elevation: 2,
                    onPressed: () {
                      setState(() {
                        _isLoading = true;
                        _kirim(hikmahController.text);
                      });
                    },
                    child: Text('Simpan', style: TextStyle(fontSize: 10.sp)),
                    // backgroundColor: Color(0xFF41436A)
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
                          _isLoading = false;
                          // _kirim(currentSelectedValue.toString());
                        });
                      },
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                      backgroundColor: Colors.grey),
                ),
          appBar: AppBar(
            backgroundColor: const Color(0xFF1d8b61),
            // actions: [
            // InkWell(
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => RekapPengajian()),
            //     );
            //   },
            //   child: Row(
            //     children: [
            //       Icon(Icons.receipt_rounded),
            //       SizedBox(
            //         width: 1.w,
            //       ),
            //       Text('Rekap'),
            //       SizedBox(
            //         width: 1.w,
            //       ),
            //     ],
            //   ),
            // )
            // ],
            title: Text(
              'Presensi Pengajian',
              style: TextStyle(fontSize: 12.sp),
            ),
          ),
          body:
              // loading == false
              //     ?
              SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 3.w, right: 3.w),
              child: Column(
                children: [
                  SizedBox(height: 3.w),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text('*',
                            style: TextStyle(
                                fontSize: 11.sp,
                                color: Colors.red,
                                fontWeight: FontWeight.w500)),
                        Text(' Tema',
                            style: TextStyle(
                                fontSize: 11.sp,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 3.w),
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                        width: MediaQuery.of(context).size.width,
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
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            )
                          ],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          widget.kegiatan ?? "",
                          style:
                              TextStyle(color: Colors.black, fontSize: 11.sp),
                        )),
                  ),
                  SizedBox(height: 3.w),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text('*',
                            style: TextStyle(
                                fontSize: 11.sp,
                                color: Colors.red,
                                fontWeight: FontWeight.w500)),
                        Text(' Hikmah',
                            style: TextStyle(
                                fontSize: 11.sp,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 3.w),
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                        width: MediaQuery.of(context).size.width,
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
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            )
                          ],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextField(
                          controller: hikmahController,
                          maxLines: 5,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        )),
                  ),
                  SizedBox(height: 3.w),
                  // Align(
                  //   alignment: Alignment.centerLeft,
                  //   child: Row(
                  //     children: [
                  //       Text('*',
                  //           style: TextStyle(
                  //               fontSize: 11.sp,
                  //               color: Colors.red,
                  //               fontWeight: FontWeight.w500)),
                  //       Text(' Lokasi',
                  //           style: TextStyle(
                  //               fontSize: 11.sp,
                  //               color: Colors.black87,
                  //               fontWeight: FontWeight.w500)),
                  //     ],
                  //   ),
                  // ),
                  // Padding(
                  //     padding: EdgeInsets.only(
                  //       top: 3.w,
                  //     ),
                  //     child: Container(
                  //         decoration: BoxDecoration(
                  //           color: Colors.white,
                  //           boxShadow: [
                  //             BoxShadow(
                  //               color: Colors.grey.withOpacity(0.1),
                  //               spreadRadius: 0.5,
                  //               blurRadius: 2,
                  //               offset:
                  //                   Offset(0, 3), // changes position of shadow
                  //             )
                  //           ],
                  //         ),
                  //         child: Row(children: <Widget>[
                  //           SizedBox(
                  //             width: 5,
                  //           ),
                  //           Container(
                  //             padding: EdgeInsets.all(5),
                  //             decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(10),
                  //               color: Color(0xFFFE6646),
                  //             ),
                  //             child: Icon(
                  //               Icons.pin_drop_outlined,
                  //               color: Colors.white,
                  //               size: 25,
                  //             ),
                  //           ),
                  //           SizedBox(
                  //             width: 3.w,
                  //           ),
                  //           // Expanded(
                  //           //   flex: 1,
                  //           //   child: DropdownButtonHideUnderline(
                  //           //     child: DropdownButton<ResponsePengajian>(
                  //           //       hint: Text(
                  //           //         "Pilih Lokasi Pengajian",
                  //           //         style: TextStyle(fontSize: 11.sp),
                  //           //       ),
                  //           //       icon: Visibility(
                  //           //           visible: true,
                  //           //           child: Icon(Icons
                  //           //               .keyboard_arrow_down_rounded)),
                  //           //       isExpanded: true,
                  //           //       items: namMasjid?.map((valuetempat) {
                  //           //         return DropdownMenuItem(
                  //           //           value: valuetempat,
                  //           //           child:
                  //           //               Text(valuetempat.tempat ?? ""),
                  //           //         );
                  //           //       }).toList(),
                  //           //       value: currentSelectedValuekampus,
                  //           //       onChanged: (ResponsePengajian? value) {
                  //           //         setState(() {
                  //           //           currentSelectedValuekampus = value;
                  //           //           hasilid = value?.id;
                  //           //           double a = double.parse(
                  //           //               value?.latitude ?? "");
                  //           //           double b = double.parse(
                  //           //               value?.longlitude ?? "");
                  //           //           pLat = a;
                  //           //           pLng = b;
                  //           //           radius =
                  //           //               int.parse(value?.radius ?? "");
                  //           //           print("halo ${hasilid}");
                  //           //           print("lat ${pLat}");
                  //           //           print("long ${pLng}");
                  //           //           print("radius ${radius}");
                  //           //         });
                  //           //       },
                  //           //     ),
                  //           //   ),
                  //           // )
                  //         ]))),
                  Padding(
                    padding: EdgeInsets.only(top: 6.w),
                    child: Container(
                        padding: EdgeInsets.all(20),
                        width: double.infinity,
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
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            )
                          ],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                            child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Address == 'Lokasi Belum di Ketahui!!'
                                    //      ||
                                    // _isMockLocation == true
                                    ? const Text(
                                        'Lokasi Belum di Ketahui!!',
                                        style:
                                            TextStyle(color: Colors.redAccent),
                                      )
                                    : Text('${Address}')))),
                  ),
                  _isLoadingLocation == false
                      ? Padding(
                          padding: EdgeInsets.only(bottom: 6.w),
                          child: InkWell(
                            onTap: () async {
                              setState(() {
                                _isLoadingLocation = true;
                              });

                              // getLocationAA();
                              await getDistance();

                              Position position =
                                  await _getGeoLocationPosition();
                              print("mnvbc");
                            },
                            child: Container(
                                padding: EdgeInsets.all(15),
                                alignment: Alignment.center,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 6.w, vertical: 6.w),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0xFF1d8b61),
                                    // color: Color(0xFF345DA7),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        spreadRadius: 0.5,
                                        blurRadius: 2,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      )
                                    ]),
                                child: Text('Klik Lokasi',
                                    style: TextStyle(
                                        fontSize: 11.sp, color: Colors.white))),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.only(bottom: 6.w),
                          child: InkWell(
                            onTap: () async {
                              setState(() {
                                _isLoadingLocation = false;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 6.w, vertical: 6.w),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey,
                                  boxShadow: []),
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                ],
              ),
            ),
          ));
      // : Center(
      //     child: CircularProgressIndicator.adaptive(
      //     backgroundColor: const Color(0xFF0a4f8f),
      //   )));
    });
  }
}
