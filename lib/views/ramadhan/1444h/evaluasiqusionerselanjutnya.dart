import 'package:attedancekaryawanump/views/homedashboard.dart';
import 'package:attedancekaryawanump/views/provider/ramadhan/1444h/provideralquran.dart';
import 'package:attedancekaryawanump/views/ramadhan/1444h/amalia_pages.dart';
import 'package:attedancekaryawanump/views/ramadhan/1444h/evaluasi.dart';
import 'package:attedancekaryawanump/views/ramadhan/1444h/pretest.dart';
import 'package:attedancekaryawanump/views/ramadhan/1444h/skorprestest.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class EvaluasiQuisionerSelanjutnya extends StatefulWidget {
  int? index;
  EvaluasiQuisionerSelanjutnya({required this.index});

  @override
  State<EvaluasiQuisionerSelanjutnya> createState() =>
      _EvaluasiQuisionerSelanjutnyaState();
}

class _EvaluasiQuisionerSelanjutnyaState
    extends State<EvaluasiQuisionerSelanjutnya> {
  int? jawaban;
  bool? loading = true;
  bool? loadingkirimquisioner = false;
  String? statusqusioner;

  getSoal() async {
    int? hasil = widget.index! + 1;
    int? back = hasil;
    final providerrekap = Provider.of<ProviderAlQuran>(context, listen: false);
    await providerrekap.getEvaluasiQusioner();
    setState(() {
      statusqusioner = providerrekap.statusquisioner;
    });
    print(statusqusioner);
    if (statusqusioner == "tutup") {
      setState(() {
        loading = providerrekap.loadingquisioner;
      });
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => HomeDashboard()));
    }
    if (statusqusioner == "selesai") {
      int? hasilaaa = widget.index! + 3;
      // int count = 0;
      // Navigator.of(context).popUntil((_) => count++ >= hasil);

      // Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(builder: (context) => SkorPretest()),
      //     (Route<dynamic> route) => false);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => Evaluasi(
                index: hasilaaa,
              )));
      setState(() {
        loading = providerrekap.loadingSoalPostest;
      });
    } else if (statusqusioner == "buka") {
      setState(() {
        loading = providerrekap.loadingSoalPostest;
      });
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getSoal();
    });

    // TODO: implement initState
    super.initState();
  }

  List<int>? soaljawbanid = [];
  List<String>? soaljawbantext = [];

  kirimSoal(String? soalid, int? jawabanid) async {
    int? hasil = widget.index! + 1;
    if (jawaban == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red.shade600,
        content: Text(
          "Anda belum memilih jawaban",
          style: TextStyle(color: Colors.white),
        ),
        duration: Duration(seconds: 3),
      ));
      setState(() {
        loadingkirimquisioner = false;
      });
    } else if (jawaban != null) {
      final providerrekap =
          Provider.of<ProviderAlQuran>(context, listen: false);
      await providerrekap.kirimEvaluasiQusioner(soalid, jawabanid);
      setState(() {
        loadingkirimquisioner = providerrekap.kirimquisioner;
        statusqusioner = providerrekap.statusquisioner;
      });
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => EvaluasiQuisionerSelanjutnya(
                index: hasil,
              )));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red.shade600,
        content: Text(
          "Error",
          style: TextStyle(color: Colors.white),
        ),
        duration: Duration(seconds: 3),
      ));
      setState(() {
        loadingkirimquisioner = false;
      });
    }
  }

  // List<int>? soaljawbanid = [];
  // List<String>? soaljawbantext = [];
  @override
  Widget build(BuildContext context) {
    int? hasil = widget.index! + 1;
    print("jumlah index ${hasil}");

    return Consumer<ProviderAlQuran>(builder: (context, v, child) {
      // print("$hasil ${v.dataquisioner!.jawaban!.length}");
      soaljawbanid = [];
      soaljawbantext = [];
      // print("idsoal = $hasil jawaban ${v.dataquisioner!.response!.length}");
      if (statusqusioner == "buka") {
        soaljawbanid = [];
        soaljawbantext = [];
        print("idsoal = $hasil jawaban ${v.dataquisioner!.response!.length}");
        if (statusqusioner == "buka") {
          if (hasil == v.dataquisioner!.response!.length) {
            statusqusioner = "selesai";
            print("buka");
          } else if (hasil > v.dataquisioner!.response!.length) {
            print("lebih");
            statusqusioner = "selesai";
          } else if (hasil < v.dataquisioner!.response!.length) {
            for (var i = 0; i < v.dataquisioner!.jawaban!.length; i++) {
              // if (v.dataquisioner!.response![hasil].soalId ==
              //     v.dataquisioner!.jawaban![i].soalId) {
              int aa = int.parse(v.dataquisioner!.jawaban![i].pilId!);
              String bb = v.dataquisioner!.jawaban![i].pilJawaban!;
              soaljawbanid?.add(aa);
              soaljawbantext?.add(bb);
              // }
            }
          }
        } else if (statusqusioner == "selesai") {
          print("aaaaaaayaa");
        }
      } else if (statusqusioner == "selesai") {
        print("aaaaaaayaa");
      }
      return Scaffold(
          appBar: AppBar(
            title: Text('Evaluasi Quisioner'),
            backgroundColor: const Color(0xFF1d8b61),
          ),
          body: loading == true
              ? Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFF1d8b61),
                  ),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 30, left: 30, right: 30, bottom: 10),
                    child: statusqusioner == "selesai"
                        ? Center(
                            child: Column(
                              children: [
                                //   Text("Selesai"),
                                //   Text("Terimakasih sudah mengisi pretest"),
                              ],
                            ),
                          )
                        : statusqusioner == "buka"
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Center(
                                      child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 3, right: 3, bottom: 10),
                                    child: Text(
                                      'Pertanyaan',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  )),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text:
                                          '${int.parse(v.dataquisioner?.response?[hasil].no ?? "")}.',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text:
                                                ' ${v.dataquisioner?.response?[hasil].soal ?? ""}?',
                                            style: TextStyle(
                                                wordSpacing: 1,
                                                fontWeight: FontWeight.normal)),
                                      ],
                                    ),
                                  ),
                                  // Text(
                                  //   '${v.dataquisioner?.response?[hasil].no}. ${v.dataquisioner?.response?[hasil].soal}?',
                                  //   style: TextStyle(
                                  //       fontSize: 15, fontWeight: FontWeight.bold),
                                  // ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 50),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        for (int i = 0;
                                            i < soaljawbanid!.length;
                                            i++)
                                          HomeContent(
                                              jawaban: soaljawbantext?[i],
                                              value: soaljawbanid?[i],
                                              groupValue: jawaban,
                                              onChanged: (int? value) {
                                                setState(() {
                                                  jawaban = value;
                                                  print("hasilnya ${value}");
                                                });
                                              }),
                                        SizedBox(
                                          height: 40,
                                        ),
                                        loadingkirimquisioner == false
                                            ? Center(
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      loadingkirimquisioner =
                                                          true;
                                                      kirimSoal(
                                                          v
                                                              .dataquisioner!
                                                              .response![hasil]
                                                              .soalId,
                                                          jawaban);
                                                    });
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 15,
                                                            horizontal: 30),
                                                    decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xFF1d8b61),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Text(
                                                      'Pertanyaan Selanjutnya',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Center(
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      loadingkirimquisioner =
                                                          false;
                                                    });
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 15,
                                                            horizontal: 30),
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Text(
                                                      'Loading',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : statusqusioner == "tutup"
                                ? Center(
                                    child: Column(
                                      children: [
                                        Text(
                                          "::Informasi::",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(v.dataErrorPretest?.metaData
                                                ?.pesan ??
                                            ""),
                                      ],
                                    ),
                                  )
                                : Center(
                                    child: Column(
                                    children: [
                                      Text(
                                        "::Informasi::",
                                        style: TextStyle(fontSize: 17),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text("Error"),
                                    ],
                                  )),
                  ),
                ));
    });
  }
}

class HomeContent extends StatelessWidget {
  final int? value;
  final int? groupValue;
  final ValueChanged<int?>? onChanged;
  String? jawaban;

  HomeContent(
      {Key? key, this.value, this.groupValue, this.onChanged, this.jawaban})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RadioListTile<int>(
      value: value!,
      groupValue: groupValue,
      onChanged: onChanged,
      activeColor: const Color(0xFF0a4f8f),
      title: Text(
        '$jawaban',
        style: TextStyle(fontSize: 14),
      ),
    );
  }
}
