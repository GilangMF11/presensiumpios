import 'package:attedancekaryawanump/views/model/modellogin.dart';
import 'package:attedancekaryawanump/views/premit/addpremit.dart';
import 'package:attedancekaryawanump/views/premit/detailspremit.dart';
import 'package:attedancekaryawanump/views/premit/editpremit.dart';
import 'package:attedancekaryawanump/views/provider/providerlogin.dart';
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

class Premit extends StatefulWidget {
  const Premit({Key? key}) : super(key: key);

  @override
  State<Premit> createState() => _PremitState();
}

class _PremitState extends State<Premit> {
  final tanggalController = TextEditingController();
  DateTime? selectedDate;
  DateTime? initialDate;

  getDataRekap() async {
    setState(() {
      loading = false;
    });
    final providerrekap =
        Provider.of<ProviderRekapPermit>(context, listen: false);
    await providerrekap.getRekapPermit(
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
  bool? loading = false;
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
            Navigator.of(context)
                .push(MaterialPageRoute(
              builder: (context) => AddPremit(),
            ))
                .then((value) {
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
          'Perizinan',
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
              child: Center(
                  child: Text(
                'Pilih Tanggal',
                style: TextStyle(
                  fontSize: 12.sp,
                ),
              ))),
          SizedBox(width: 1.w),
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
              size: 3.h,
            ),
          ),
          SizedBox(width: 4.w)
        ],
      ),
      body: Consumer<ProviderRekapPermit>(
          builder: (BuildContext context, v, Widget? child) {
        // print(v.data?.data?.length);
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
                              'Riwayat Perizinan',
                              style: TextStyle(
                                fontSize: 11.sp,
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
                              if (v.data!.data!.isNotEmpty)
                                ...v.data!.data!
                                    .where((e) => e.id != null)
                                    .map((e) => InkWell(
                                          onTap: () {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailsPremit(
                                                id: e.id,
                                                alasan: e.tipePermit,
                                                widTanggaMulai: e.tglMulai,
                                                widTanggaSelesai: e.tglAkhir,
                                                keterangan: e.keterangan,
                                                gambar: e.file,
                                              ),
                                            ))
                                                .then((value) {
                                              getbulan();
                                              getDataRekap();
                                              _Login();
                                            });
                                          },
                                          child: cardView(
                                              e.tglMulai,
                                              e.tglAkhir,
                                              data?.data?.nama,
                                              e.tipePermit.toString(),
                                              e.keterangan,
                                              e.status),
                                        ))
                              else ...{
                                Center(
                                    child: Padding(
                                        padding: EdgeInsets.only(top: 2.h),
                                        child: Center(
                                            child: Text(
                                          "Tidak Ada Izin Pada Bulan Ini",
                                          style: TextStyle(
                                            fontSize: 11.sp,
                                          ),
                                        ))))
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

  Widget cardView(String? tanggalawall, String? tanggalAkhirr, String? nama,
      String? type, String? keterangan, int? status) {
    initializeDateFormatting();
    String? conTanggalAwal =
        DateFormat.yMMMMd('id').format(DateTime.parse(tanggalawall.toString()));
    String? conTanggalAkhir = DateFormat.yMMMMd('id')
        .format(DateTime.parse(tanggalAkhirr.toString()));
    // DateFormat formatYear = DateFormat("yyyy-MM-dd");
    // DateFormat formatDay = DateFormat("dd");
    // DateFormat formatMon = DateFormat("MM");
    print(conTanggalAwal);
    return Padding(
      padding: EdgeInsets.only(top: 3.w),
      child: Container(
        padding: EdgeInsets.only(top: 15, bottom: 15),
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
          mainAxisSize: MainAxisSize.max,
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
                // Sampai ${tanggalAkhirr?.substring(0, 10)}
                // formatDay.parse(tanggalawall.toString().substring(8, 10)).day} ${formatMon.parse(tanggalawall.toString().substring(5, 7)).month}
                "${conTanggalAwal} - ${conTanggalAkhir}",
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(13),
                      decoration: BoxDecoration(
                          color: Color(0xFFF5F5F5), shape: BoxShape.circle),
                      child: Icon(
                        Icons.access_time_filled_rounded,
                        // color: Colors.white,
                        // color: Color(0xFFC4C4C4),
                        color: Color(0xFF2b7cc4),
                        size: 8.w,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
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
                        type == null
                            ? Text(
                                'Tipe : Belum di Set',
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  color: Colors.black,
                                ),
                              )
                            : type == "1"
                                ? Text(
                                    'Tipe : Sakit',
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      color: Colors.black,
                                    ),
                                  )
                                : type == "2"
                                    ? Text(
                                        'Tipe : Izin',
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          color: Colors.black,
                                        ),
                                      )
                                    : type == "3"
                                        ? Text(
                                            'Tipe : Dinas Luar',
                                            style: TextStyle(
                                              fontSize: 11.sp,
                                              color: Colors.black,
                                            ),
                                          )
                                        : type == "4"
                                            ? Text(
                                                'Tipe : Cuti',
                                                style: TextStyle(
                                                  fontSize: 11.sp,
                                                  color: Colors.black,
                                                ),
                                              )
                                            : type == "5"
                                                ? Text('Tipe : Izin Belajar',
                                                    style: TextStyle(
                                                      fontSize: 11.sp,
                                                      color: Colors.black,
                                                    ))
                                                : Container(),
                        SizedBox(
                          height: 1.w,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Flexible(
                              child: Text(
                                'Alasan : $keterangan',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  color: Colors.black,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                status == 0
                                    ? Container(
                                        margin: EdgeInsets.only(right: 10),
                                        padding: const EdgeInsets.only(
                                            top: 7,
                                            bottom: 7,
                                            right: 10,
                                            left: 10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          // color: Color(0xFF2b7cc4),
                                          color: Colors.orange.shade700,
                                        ),
                                        child: Text(
                                          // Sampai ${tanggalAkhirr?.substring(0, 10)}
                                          // formatDay.parse(tanggalawall.toString().substring(8, 10)).day} ${formatMon.parse(tanggalawall.toString().substring(5, 7)).month}
                                          "Menunggu",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 9.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )
                                    : Container(),
                                status == 1
                                    ? Container(
                                        margin: EdgeInsets.only(right: 10),
                                        padding: const EdgeInsets.only(
                                            top: 7,
                                            bottom: 7,
                                            right: 10,
                                            left: 10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.green.shade800,
                                        ),
                                        child: Text(
                                          // Sampai ${tanggalAkhirr?.substring(0, 10)}
                                          // formatDay.parse(tanggalawall.toString().substring(8, 10)).day} ${formatMon.parse(tanggalawall.toString().substring(5, 7)).month}
                                          "Diterima",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 9.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )
                                    : Container(),
                                status == 2
                                    ? Container(
                                        margin: EdgeInsets.only(right: 10),
                                        padding: const EdgeInsets.only(
                                            top: 7,
                                            bottom: 7,
                                            right: 10,
                                            left: 10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.red.shade800,
                                        ),
                                        child: Text(
                                          // Sampai ${tanggalAkhirr?.substring(0, 10)}
                                          // formatDay.parse(tanggalawall.toString().substring(8, 10)).day} ${formatMon.parse(tanggalawall.toString().substring(5, 7)).month}
                                          "Ditolak",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 9.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )
                                    : Container()
                              ],
                            )
                          ],
                        )
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
                        height: 0.5.w,
                      ),
                      SizedBox(
                        width: 45.w,
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
                        height: 0.5.w,
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
