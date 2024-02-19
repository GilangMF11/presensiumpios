import 'package:attedancekaryawanump/views/provider/providerrekap.dart';
import 'package:flutter/material.dart';
import 'package:mat_month_picker_dialog/mat_month_picker_dialog.dart';
// import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class Rekap extends StatefulWidget {
  const Rekap({Key? key}) : super(key: key);

  @override
  State<Rekap> createState() => _RekapState();
}

class _RekapState extends State<Rekap> {
  bool? loading = false;
  final tanggalController = TextEditingController();
  DateTime? selectedDate;
  DateTime? initialDate;

  getDataRekap() async {
    loading = false;
    final providerrekap = Provider.of<ProviderRekap>(context, listen: false);
    await providerrekap.getRekap(
        selectedDate?.year.toString(), selectedDate?.month.toString());
    setState(() {
      loading = providerrekap.loading;
    });
  }

  @override
  void initState() {
    super.initState();
    initialDate = DateTime.now();
    selectedDate = initialDate;
    getbulan();
    getDataRekap();
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
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Builder(
        builder: (context) => SizedBox(
          height: 15.h,
          width: 15.w,
          child: FloatingActionButton(
            backgroundColor: Color.fromARGB(255, 223, 84, 56),
            onPressed: () async {
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
              Icons.calendar_today,
              size: 3.h,
            ),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0a4f8f),
        title: Text(
          'Rekap Bulan ${bulan} Tahun ${selectedDate?.year}',
          style: TextStyle(fontSize: 12.sp),
        ),
      ),
      body: Consumer<ProviderRekap>(
          builder: (BuildContext context, v, Widget? child) {
        return RefreshIndicator(
          onRefresh: () async {
            getbulan();
            getDataRekap();
          },
          child: ListView(
            children: [
              Container(
                // color: const Color(0xFF0a4f8f),
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  color: const Color(0xFF0a4f8f),
                ))),
                padding:
                    EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 15),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 2,
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Hari",
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: const Color(0xFF0a4f8f),
                              ),
                            ))),
                    Expanded(
                        flex: 2,
                        child: Center(
                            child: Text(
                          "Tanggal",
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: const Color(0xFF0a4f8f),
                          ),
                        ))),
                    Expanded(
                        flex: 2,
                        child: Center(
                            child: Text(
                          "Masuk",
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: const Color(0xFF0a4f8f),
                          ),
                        ))),
                    Expanded(
                        flex: 2,
                        child: Center(
                            child: Text(
                          "Pulang",
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: const Color(0xFF0a4f8f),
                          ),
                        ))),
                    Expanded(
                        flex: 2,
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Flag",
                              style: TextStyle(
                                  fontSize: 11.sp,
                                  color: const Color(0xFF0a4f8f)),
                            ))),
                  ],
                ),
              ),
              // Center(
              //   child: Text(
              //     'Year: ${selectedDate?.year}\nMonth: ${selectedDate?.month}',
              //     style: Theme.of(context).textTheme.headline4,
              //     textAlign: TextAlign.center,
              //   ),
              // ),
              loading == true
                  ? Column(children: [
                      if (v.data!.data!.length > 0)
                        ...v.data!.data!.where((e) => e.hari != null).map((e) =>
                            _listRekap(
                                e.hari, e.tanggal, e.masuk, e.keluar, e.label))
                      else ...{
                        Center(
                            child: Padding(
                          padding: EdgeInsets.only(top: 2.h),
                          child: Text(
                            "Tidak Ada Presensi Pada Bulan Ini",
                            style: TextStyle(
                              fontSize: 12.sp,
                            ),
                          ),
                        ))
                      }
                    ])
                  : Container(
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 7,
                        itemBuilder: (BuildContext context, int index) {
                          return _listRekapLoading();
                        },
                      ),
                    )
            ],
          ),
        );
      }),
    );
  }

  _listRekap(String? hari, String? tanggal, String? masuk, String? pulang,
      String? flag) {
    return Container(
      padding: EdgeInsets.all(0),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 2,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          hari ?? "",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10.5.sp,
                          ),
                        ))),
                Expanded(
                    flex: 2,
                    child: Center(
                        child: Text(
                      tanggal ?? "",
                      style: TextStyle(fontSize: 10.5.sp, color: Colors.black),
                    ))),
                Expanded(
                    flex: 2,
                    child: Center(
                        child: Text(
                      masuk ?? "",
                      style: TextStyle(fontSize: 10.5.sp, color: Colors.black),
                    ))),
                Expanded(
                    flex: 2,
                    child: Center(
                        child: Text(
                      pulang ?? "",
                      style: TextStyle(fontSize: 10.5.sp, color: Colors.black),
                    ))),
                Expanded(
                    flex: 2,
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          flag ?? "",
                          style:
                              TextStyle(fontSize: 10.5.sp, color: Colors.black),
                        ))),
              ],
            ),
          ),
          Divider(
            color: Colors.grey,
            thickness: 1,
          )
        ],
      ),
    );
  }

  _listRekapLoading() {
    return Container(
      padding: EdgeInsets.all(0),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 5.h,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        color: Colors.white,
                      ),
                    ),
                  ),
                )),
              ],
            ),
          ),
          // Divider(
          //   color: Colors.grey,
          //   thickness: 1,
          // )
        ],
      ),
    );
  }
}
