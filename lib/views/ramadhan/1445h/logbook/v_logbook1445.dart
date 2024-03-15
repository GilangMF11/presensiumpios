import 'package:attedancekaryawanump/views/model/modellogin.dart';
import 'package:attedancekaryawanump/views/provider/providerlogin.dart';
import 'package:attedancekaryawanump/views/provider/ramadhan/1445h/model/logbookModel1445.dart';
import 'package:attedancekaryawanump/views/provider/ramadhan/1445h/providerRamadhan1445.dart';
import 'package:attedancekaryawanump/views/ramadhan/1445h/logbook/v_add_logbook1445.dart';
import 'package:attedancekaryawanump/views/ramadhan/1445h/logbook/v_detail_logbook1445.dart';
import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class LogBookRamadhan1445 extends StatefulWidget {
  const LogBookRamadhan1445({Key? key}) : super(key: key);

  @override
  State<LogBookRamadhan1445> createState() => _LogBookRamadhan1445State();
}

class _LogBookRamadhan1445State extends State<LogBookRamadhan1445> {
  final tanggalController = TextEditingController();
  DateTime? selectedDate;
  DateTime? initialDate;
  bool? loading = false;
  ModelLogbook1445? modelLogbook1445;
  getDataRekap() async {
    setState(() {
      loading = false; // Set loading to true when data retrieval starts
    });

    try {
      final providerrekap =
          Provider.of<ProviderRamadhan1445>(context, listen: false);
      await providerrekap.getDataLogbook();
      loading = providerrekap.loadingLogbookRamadhan;
      print("loading : $loading");
    } catch (error) {
      print("Error in getDataRekap: $error");
      // Handle error (show a message, set loading to false, etc.)
    } 
    
  }

  _Login() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      bool? status = prefs.getBool('status');
      String? token = prefs.getString('token');
      String? username = prefs.getString('usernameLogin');
      String? password = prefs.getString('passwordLogin');

      final _providerLogin = Provider.of<ProviderLogin>(context, listen: false);
      await _providerLogin.providerLogin(username, password);
    } catch (error) {
      print("Error in _Login: $error");
      // Handle error (show a message, redirect to login, etc.)
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataRekap();
    _Login();
    print("Data : ${modelLogbook1445?.response[0]}");
    // final data = getDataRekap();
    // var x = data['response'][0];
    // print("data $x");
  }

  @override
  Widget build(BuildContext context) {
    ModelLogin? data = Provider.of<ProviderLogin>(context, listen: true).data;
    return Scaffold(
      floatingActionButton: SizedBox(
        height: 15.h,
        width: 15.w,
        child: FloatingActionButton(
          elevation: 2,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddLogBook1445()));
          },
          child: const Icon(Icons.add),
          backgroundColor: const Color.fromARGB(255, 223, 84, 56),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF1d8b61),
        title: Text(
          "Log Book",
          style: TextStyle(fontSize: 12.sp),
        ),
        // actions: [
        //   // aksi
        //   Icon(
        //     Icons.date_range_rounded,
        //     color: Colors.white,
        //     size: 7.w,
        //   ),
        //   SizedBox(
        //     width: 4.w,
        //   )
        // ],
      ),
      body: Consumer<ProviderRamadhan1445>(
        builder: (BuildContext context, v, Widget? child) {
          return RefreshIndicator(
            onRefresh: () async {
              getDataRekap();
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              //tabBarTogle = false;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                bottom: BorderSide(
                                  width: 1.5,
                                  color: Color(0xFF1d8b61),
                                ),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Riwayat Logbook',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: const Color(0xFF1d8b61),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 3.w, right: 3.w, top: 3.w),
                    child: Column(
                      children: [
                        loading == true
                            ? Column(
                                children: [
                                  if (v.dataLogbook?.response != null &&
                                      v.dataLogbook!.response.isNotEmpty)
                                    ...?v.dataLogbook?.response.map(
                                      (logbook) => GestureDetector(
                                        onTap: () {
                                          //print("ID : ${logbook.logbookId}");
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailLogBookRamadhan1445(
                                                        id: logbook.logbookId,
                                                        tanggal:
                                                            logbook.tanggal,
                                                        widJamMulai:
                                                            logbook.jamMulai,
                                                        widJamSelesai:
                                                            logbook.jamAkhir,
                                                        jKegiatan: logbook
                                                            .jenisKegiatan,
                                                        keterangan:
                                                            logbook.keterangan,
                                                      )));
                                        },
                                        child: cardView(
                                          logbook.tanggal,
                                          logbook.jamMulai,
                                          logbook.jamAkhir,
                                          logbook.jenisKegiatan,
                                          logbook.keterangan,
                                        ),
                                      ),
                                    )
                                  else
                                    Center(
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 2.h),
                                        child: const Center(
                                          child: Text("Tidak Ada Data"),
                                        ),
                                      ),
                                    ),
                                ],
                              )
                            : SizedBox(
                                height: MediaQuery.of(context).size.height,
                                child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: 3,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return cardViewLoading();
                                  },
                                ),
                              )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// Widget

Widget cardView(String? tanggal, String? tanggalawall, String? tanggalAkhirr,
    String? nama, String? keterangan) {
  initializeDateFormatting();
  String? conTanggalAwal =
      DateFormat.yMMMMEEEEd('id').format(DateTime.parse(tanggal.toString()));
  return Padding(
    padding: EdgeInsets.only(top: 3.w),
    child: Container(
      padding: const EdgeInsets.only(right: 10, top: 15, bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 0.5,
            blurRadius: 2,
            offset: const Offset(0, 3), // changes position of shadow
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding:
                const EdgeInsets.only(top: 7, bottom: 7, right: 20, left: 10),
            decoration: const BoxDecoration(
                color: Color(0xFF1d8b61),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(15),
                    topRight: Radius.circular(15))),
            child: Text(
              "${conTanggalAwal}",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: 2.w,
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(13),
                    decoration: const BoxDecoration(
                        color: Color(0xFFF5F5F5), shape: BoxShape.circle),
                    child: Icon(
                      FlutterIslamicIcons.calendar,
                      color: const Color(0xFF1d8b61),
                      // color: const Color(0xFFC4C4C4),
                      size: 8.w,
                    ),
                  ),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nama ?? "",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 1.w,
                      ),
                      Text(
                          "Jam : ${tanggalawall.toString().substring(0, 5)} Sampai ${tanggalAkhirr.toString().substring(0, 5)}",
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: Colors.black,
                          )),
                      SizedBox(
                        height: 1.w,
                      ),
                      Text(
                        "Keterangan : $keterangan",
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget cardViewLoading() {
  return Padding(
    padding: EdgeInsets.only(top: 3.w),
    child: Container(
      padding: const EdgeInsets.only(right: 10, top: 15, bottom: 15),
      decoration: BoxDecoration(
          boxShadow: [],
          borderRadius: BorderRadius.circular(10),
          color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: 20.w,
              height: 2.h,
              padding:
                  const EdgeInsets.only(top: 7, bottom: 7, right: 20, left: 10),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(15),
                      topRight: Radius.circular(15))),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: 2.w,
            ),
            child: Row(
              children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        padding: const EdgeInsets.all(13),
                        decoration: const BoxDecoration(
                            color: Color(0xFFF5F5F5), shape: BoxShape.circle),
                        child: Icon(
                          Icons.access_alarm_rounded,
                          // color: Colors.white,
                          color: const Color(0xFFC4C4C4),
                          size: 8.w,
                        ),
                      ),
                    )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 50.w,
                      height: 2.3.h,
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1.w,
                    ),
                    SizedBox(
                      width: 40.w,
                      height: 2.3.h,
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1.w,
                    ),
                    SizedBox(
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
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
