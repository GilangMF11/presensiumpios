import 'package:attedancekaryawanump/views/provider/ramadhan/1444h/provideralquran.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class Evaluasi extends StatefulWidget {
  int? index;
  Evaluasi({Key? key, this.index}) : super(key: key);

  @override
  State<Evaluasi> createState() => _EvaluasiState();
}

class _EvaluasiState extends State<Evaluasi> {
  String? statusEval;
  bool? loadingeval = true;
  bool? loadingkirim = false;
  bool? loadinghapus = false;
  var kritikController = TextEditingController();
  var saranController = TextEditingController();
  getCekKetersedian() async {
    final providerrekap = Provider.of<ProviderAlQuran>(context, listen: false);
    await providerrekap.cekEvaluasi();
    setState(() {
      statusEval = providerrekap.statusevaluasi;
      loadingeval = providerrekap.loadingcekstatuseval;
      kritikController = TextEditingController()..text = providerrekap.kritik!;
      saranController = TextEditingController()..text = providerrekap.saran!;
    });
  }

  kirimEval(String? kritikA, String? saranA) async {
    final providerrekap = Provider.of<ProviderAlQuran>(context, listen: false);
    print(kritikA);
    print(saranA);
    await providerrekap.kirimEvaluasi(kritikA, saranA);
    String? hasil = providerrekap.statuskirimEval;
    print(hasil);
    if (hasil == "berhasil") {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Color(0xFF1d8b61),
          content: Text(
            "Jawaban Berhasil dikirim",
            style: TextStyle(color: Colors.white),
          ),
          duration: Duration(seconds: 3),
        ));
        loadingkirim = providerrekap.laodingkirimeval;
        // Navigator.pop(context);
        int count = 0;
        int hasilaa = widget.index!;
        print(hasilaa);
        Navigator.of(context).popUntil((_) => count++ >= hasilaa);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red.shade600,
        content: Text(
          "Gagal",
          style: TextStyle(color: Colors.white),
        ),
        duration: Duration(milliseconds: 300),
      ));
      setState(() {
        loadingkirim = providerrekap.laodingkirimeval;
      });
    }
  }

  hapusEval() async {
    final providerrekap = Provider.of<ProviderAlQuran>(context, listen: false);

    await providerrekap.hapusEvaluasi();
    String? hasil = providerrekap.statuskirimEval;
    print(hasil);
    if (hasil == "berhasil") {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Color(0xFF1d8b61),
          content: Text(
            "Hapus Jawaban Berhasil",
            style: TextStyle(color: Colors.white),
          ),
          duration: Duration(seconds: 3),
        ));
        loadinghapus = providerrekap.laodingkirimeval;

        int count = 0;
        int hasilaa = widget.index!;
        Navigator.of(context).popUntil((_) => count++ >= hasilaa);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red.shade600,
        content: Text(
          "Gagal",
          style: TextStyle(color: Colors.white),
        ),
        duration: Duration(milliseconds: 300),
      ));
      setState(() {
        loadinghapus = providerrekap.laodingkirimeval;
      });
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getCekKetersedian();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Evaluasi'),
          backgroundColor: const Color(0xFF1d8b61),
        ),
        body: loadingeval == true
            ? Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF1d8b61),
                ),
              )
            : SingleChildScrollView(
                child: statusEval == "belum"
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Masukan kritik dan saran',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Text('*',
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          color: Colors.red,
                                          fontWeight: FontWeight.w500)),
                                  Text(' Kritik',
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
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 2),
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
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: TextField(
                                    controller: kritikController,
                                    maxLines: 5,
                                    maxLength: 500,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Text('*',
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          color: Colors.red,
                                          fontWeight: FontWeight.w500)),
                                  Text(' Saran',
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
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 2),
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
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: TextField(
                                    controller: saranController,
                                    maxLines: 5,
                                    maxLength: 500,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Center(
                                child: loadingkirim == false
                                    ? InkWell(
                                        onTap: () {
                                          setState(() {
                                            kirimEval(kritikController.text,
                                                saranController.text);
                                            loadingkirim = true;
                                          });
                                        },
                                        child: Container(
                                          width: 200,
                                          padding: EdgeInsets.symmetric(
                                            vertical: 15,
                                          ),
                                          decoration: BoxDecoration(
                                              color: const Color(0xFF1d8b61),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Center(
                                            child: Text(
                                              'Kirim Jawaban',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      )
                                    : InkWell(
                                        onTap: () {
                                          setState(() {
                                            loadingkirim = false;
                                          });
                                        },
                                        child: Container(
                                          width: 200,
                                          padding: EdgeInsets.symmetric(
                                            vertical: 15,
                                          ),
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade500,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Center(
                                            child: Text(
                                              'loading',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      )),
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Masukan kritik dan saran',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Text('*',
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          color: Colors.red,
                                          fontWeight: FontWeight.w500)),
                                  Text('Kritik',
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
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 2),
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
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: TextField(
                                    controller: kritikController,
                                    maxLines: 5,
                                    maxLength: 500,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Text('*',
                                      style: TextStyle(
                                          fontSize: 11.sp,
                                          color: Colors.red,
                                          fontWeight: FontWeight.w500)),
                                  Text(' Saran',
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
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 2),
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
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: TextField(
                                    controller: saranController,
                                    maxLines: 5,
                                    maxLength: 500,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return StatefulBuilder(
                                          builder: (context, setState) {
                                        return AlertDialog(
                                          title: Text(
                                            "Apakah kamu akan menghapus jawaban ini?",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          content: Row(
                                            children: [
                                              Expanded(
                                                  flex: 5,
                                                  child: loadinghapus == false
                                                      ? Container(
                                                          decoration: BoxDecoration(
                                                              color: Colors
                                                                  .red.shade600,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                          child: TextButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                hapusEval();
                                                                loadinghapus =
                                                                    true;
                                                              });
                                                            },
                                                            child: Text(
                                                              "Ya",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ))
                                                      : Container(
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.grey,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                          child: TextButton(
                                                            onPressed: () {
                                                              setState(() {});
                                                            },
                                                            child: Text(
                                                              "Loading",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ))),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                flex: 5,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Color(0xFF1d8b61),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text(
                                                        "Tidak",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )),
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      });
                                    });
                              },
                              child: Row(
                                children: [
                                  Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 5),
                                      decoration: BoxDecoration(
                                        color: Colors.red.shade600,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      )),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Hapus Jawaban',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black54),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Center(
                                child: loadingkirim == false
                                    ? InkWell(
                                        onTap: () {
                                          setState(() {
                                            kirimEval(kritikController.text,
                                                saranController.text);
                                            loadingkirim = true;
                                          });
                                        },
                                        child: Container(
                                          width: 200,
                                          padding: EdgeInsets.symmetric(
                                            vertical: 15,
                                          ),
                                          decoration: BoxDecoration(
                                              color: const Color(0xFF1d8b61),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Center(
                                            child: Text(
                                              'Kirim Jawaban',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      )
                                    : InkWell(
                                        onTap: () {
                                          setState(() {
                                            loadingkirim = false;
                                          });
                                        },
                                        child: Container(
                                          width: 200,
                                          padding: EdgeInsets.symmetric(
                                            vertical: 15,
                                          ),
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade500,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Center(
                                            child: Text(
                                              'loading',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      )),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
              ));
  }
}