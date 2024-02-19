import 'package:attedancekaryawanump/views/lembur/addlembur.dart';
import 'package:attedancekaryawanump/views/log/addlog.dart';
import 'package:attedancekaryawanump/views/log/detailslog.dart';
import 'package:attedancekaryawanump/views/model/modellogin.dart';
import 'package:attedancekaryawanump/views/premit/addpremit.dart';
import 'package:attedancekaryawanump/views/provider/providerlogin.dart';
import 'package:attedancekaryawanump/views/provider/providerrekaplogbook.dart';
import 'package:attedancekaryawanump/views/provider/providerrekappremit.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:mat_month_picker_dialog/mat_month_picker_dialog.dart';
// import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class Log extends StatefulWidget {
  const Log({Key? key}) : super(key: key);

  @override
  State<Log> createState() => _LogState();
}

class _LogState extends State<Log> {
  final tanggalController = TextEditingController();
  DateTime? selectedDate;
  DateTime? initialDate;
  bool? loading = false;

  getDataRekap() async {
    loading = false;
    final providerrekap =
        Provider.of<ProviderRekapLogbook>(context, listen: false);
    await providerrekap.getRekapLogbook(
        selectedDate?.year.toString(), selectedDate?.month.toString());
    loading = providerrekap.loading;
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
    final _providerLogin =
        await Provider.of<ProviderLogin>(context, listen: false);
    await _providerLogin.providerLogin(username, password);
  }

  String? bulan;
  getbulan() {
    if (selectedDate?.month == 1) {
      setState(() {
        bulan = "Januari";
      });
    } else if (selectedDate?.month == 2) {
      setState(() {
        bulan = "Fabuari";
      });
    } else if (selectedDate?.month == 3) {
      setState(() {
        bulan = "Maret";
      });
    } else if (selectedDate?.month == 4) {
      setState(() {
        bulan = "April";
      });
    } else if (selectedDate?.month == 5) {
      setState(() {
        bulan = "Mei";
      });
    } else if (selectedDate?.month == 6) {
      setState(() {
        bulan = "Juni";
      });
    } else if (selectedDate?.month == 7) {
      setState(() {
        bulan = "Juli";
      });
    } else if (selectedDate?.month == 8) {
      setState(() {
        bulan = "Agustus";
      });
    } else if (selectedDate?.month == 9) {
      setState(() {
        bulan = "September";
      });
    } else if (selectedDate?.month == 10) {
      setState(() {
        bulan = "Oktober";
      });
    } else if (selectedDate?.month == 11) {
      setState(() {
        bulan = "November";
      });
    } else if (selectedDate?.month == 12) {
      setState(() {
        bulan = "Desember";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    initialDate = DateTime.now();
    selectedDate = initialDate;
    getbulan();
    getDataRekap();
    _Login();
  }

  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //       context: context,
  //       initialDate: selectedDate!,
  //       firstDate: DateTime(2015, 8),
  //       lastDate: DateTime(2101));
  //   if (picked != null && picked != selectedDate) {
  //     setState(() {
  //       selectedDate = picked;
  //       getbulan();
  //       getDataRekap();
  //     });
  //   }
  // }

  bool tabBarTogle = false;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    ModelLogin? data = Provider.of<ProviderLogin>(context, listen: true).data;
    return Scaffold(
      floatingActionButton:
          // _isLoading == false
          //     ?
          SizedBox(
        height: 15.h,
        width: 15.w,
        child: FloatingActionButton(
          elevation: 2,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddLog()),
            ).then((value) {
              getbulan();
              getDataRekap();
              _Login();
            });
          },
          child: Icon(Icons.add),
          // backgroundColor: Color(0xFF2b7cc4),
          backgroundColor: Color.fromARGB(255, 223, 84, 56),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF0a4f8f),
        title: Text(
          'Logbook',
          style: TextStyle(fontSize: 12.sp),
        ),
        actions: [
          InkWell(
              onTap: () async {
                final selected = await showMonthPicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1970),
                    lastDate: DateTime(2050));
                if (selected != null) {
                  setState(() {
                    selectedDate = selected;
                    getbulan();
                    getDataRekap();
                  });
                }
                // // showMonthPicker(
                // //   context: context,
                // //   firstDate: DateTime(DateTime.now().year - 3, 5),
                // //   lastDate: DateTime(DateTime.now().year + 0, 12),
                // //   initialDate: selectedDate ?? initialDate!,
                // //   locale: Locale("en"),
                // // ).then((date) {
                // //   if (date != null) {
                // //     setState(() {
                // //       selectedDate = date;
                // //       getbulan();
                // //       getDataRekap();
                // //     });
                //   }
                // });
              },
              child: Center(child: Text('Pilih Tanggal'))),
          SizedBox(width: 1.w),
          InkWell(
            onTap: () async {
              // _selectDate(context);
              final selected = await showMonthPicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1970),
                  lastDate: DateTime(2050));
              if (selected != null) {
                setState(() {
                  selectedDate = selected;
                  getbulan();
                  getDataRekap();
                });
              }
              // showMonthPicker(
              //   context: context,
              //   firstDate: DateTime(DateTime.now().year - 3, 5),
              //   lastDate: DateTime(DateTime.now().year + 0, 12),
              //   initialDate: selectedDate ?? initialDate!,
              //   locale: Locale("en"),
              // ).then((date) {
              //   if (date != null) {
              //     setState(() {
              //       selectedDate = date;
              //       getbulan();
              //       getDataRekap();
              //     });
              //   }
              // });
            },
            child: Icon(
              Icons.date_range_rounded,
              color: Colors.white,
              size: 7.w,
            ),
          ),
          SizedBox(width: 4.w)
        ],
      ),
      body: Consumer<ProviderRekapLogbook>(
          builder: (BuildContext context, v, Widget? child) {
        return RefreshIndicator(
          onRefresh: () async {
            getbulan();
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
                            tabBarTogle = false;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                bottom: BorderSide(
                                  width: 1.5,
                                  color: Color(0xFF0a4f8f),
                                ),
                              )),
                          child: Center(
                            child: Text(
                              'Riwayat Logbook',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Color(0xFF0a4f8f),
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
                          ? Column(children: [
                              if (v.data!.data!.length > 0)
                                ...v.data!.data!
                                    .where((e) => e.id != null)
                                    .map((e) => InkWell(
                                          onTap: () {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                              builder: (context) => DetailsLog(
                                                id: e.id,
                                                tanggal: e.tanggal,
                                                widJamMulai: e.jamMulai,
                                                widJamSelesai: e.jamSelesai,
                                                catatan: e.catatan,
                                              ),
                                            ))
                                                .then((value) {
                                              getbulan();
                                              getDataRekap();
                                              _Login();
                                            });
                                          },
                                          child: cardView(
                                            e.tanggal,
                                            e.jamMulai,
                                            e.jamSelesai,
                                            data?.data?.nama,
                                            e.catatan,
                                          ),
                                        ))
                              else ...{
                                Center(
                                    child: Padding(
                                        padding: EdgeInsets.only(top: 2.h),
                                        child: Center(
                                            child: Text(
                                                "Tidak Ada Log Pada Bulan Ini"))))
                              }
                            ])
                          : SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: 3,
                                itemBuilder: (BuildContext context, int index) {
                                  return cardViewLoading();
                                },
                              ),
                            )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget cardView(String? tanggal, String? tanggalawall, String? tanggalAkhirr,
      String? nama, String? keterangan) {
    initializeDateFormatting();
    String? conTanggalAwal =
        DateFormat.yMMMMEEEEd('id').format(DateTime.parse(tanggal.toString()));
    return Padding(
      padding: EdgeInsets.only(top: 3.w),
      child: Container(
        padding: EdgeInsets.only(right: 10, top: 15, bottom: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 0.5,
              blurRadius: 2,
              offset: Offset(0, 3), // changes position of shadow
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
                  color: Color(0xFF2b7cc4),
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
                        Icons.note_add,
                        color: const Color(0xFF2b7cc4),
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
        padding: EdgeInsets.only(right: 10, top: 15, bottom: 15),
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
                padding: const EdgeInsets.only(
                    top: 7, bottom: 7, right: 20, left: 10),
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
                          padding: EdgeInsets.all(13),
                          decoration: BoxDecoration(
                              color: Color(0xFFF5F5F5), shape: BoxShape.circle),
                          child: Icon(
                            Icons.access_alarm_rounded,
                            // color: Colors.white,
                            color: Color(0xFFC4C4C4),
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
}