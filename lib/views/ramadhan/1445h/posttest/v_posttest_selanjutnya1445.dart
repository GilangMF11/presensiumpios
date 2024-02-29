import 'package:attedancekaryawanump/views/homedashboard.dart';
import 'package:attedancekaryawanump/views/provider/ramadhan/1445h/providerRamadhan1445.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PosttestSelanjutnya1445 extends StatefulWidget {
  int? index;
  PosttestSelanjutnya1445({required this.index});

  @override
  State<PosttestSelanjutnya1445> createState() => _PosttestSelanjutnya1445State();
}

class _PosttestSelanjutnya1445State extends State<PosttestSelanjutnya1445> {
  int? jawaban;
  bool? loading = true;
  String? statuspostest;
  bool? loadingkirimpostest = false;

  getSoal() async {
    int? hasil = widget.index! + 1;
    int? back = hasil;
    final providerrekap = Provider.of<ProviderRamadhan1445>(context, listen: false);
    await providerrekap.getSoalPos();
    setState(() {
      statuspostest = providerrekap.statuspostest;
    });
    print(statuspostest);
    if (statuspostest == "tutup") {
      setState(() {
        loading = providerrekap.loadingSoalPostest;
      });
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => HomeDashboard()));
    }
    if (statuspostest == "selesai") {
      int count = 0;
      Navigator.of(context).popUntil((_) => count++ >= hasil);

      // Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(builder: (context) => SkorPretest()),
      //     (Route<dynamic> route) => false);
      // Navigator.of(context).push(
      //     MaterialPageRoute(builder: (BuildContext context) => SkoPreterPretest()));
      setState(() {
        loading = providerrekap.loadingSoalPostest;
      });
    } else if (statuspostest == "buka") {
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
        loadingkirimpostest = false;
      });
    } else if (jawaban != null) {
      final providerrekap =
          Provider.of<ProviderRamadhan1445>(context, listen: false);
      await providerrekap.kirimSoalPostestJawab(soalid, jawabanid);
      setState(() {
        loadingkirimpostest = providerrekap.kirimSoalPostest;
        statuspostest = providerrekap.statuspostest;
      });
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => PosttestSelanjutnya1445(
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
        loadingkirimpostest = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    int? hasil = widget.index! + 1;
    print("jumlah index ${hasil}");

    return Consumer<ProviderRamadhan1445>(builder: (context, v, child) {
      // print("$hasil ${v.datapostest!.jawaban!.length}");
      soaljawbanid = [];
      soaljawbantext = [];
      print("idsoal = $hasil jawaban ${v.datapostest!.response!.length}");
      if (statuspostest == "buka") {
        if (hasil == v.datapostest!.response!.length) {
          statuspostest = "selesai";
          print("buka");
        } else if (hasil > v.datapostest!.response!.length) {
          print("lebih");
          statuspostest = "selesai";
        } else if (hasil < v.datapostest!.response!.length) {
          for (var i = 0; i < v.datapostest!.jawaban!.length; i++) {
            if (v.datapostest!.response![hasil].soalId ==
                v.datapostest!.jawaban![i].soalId) {
              int aa = int.parse(v.datapostest!.jawaban![i].pilId!);
              String bb = v.datapostest!.jawaban![i].pilJawaban!;
              soaljawbanid?.add(aa);
              soaljawbantext?.add(bb);
            }
          }
        }
      } else if (statuspostest == "selesai") {
        print("aaaaaaayaa");
      }
      return Scaffold(
          appBar: AppBar(
            title: Text('Postest'),
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
                    child: statuspostest == "selesai"
                        ? Center(
                            child: Column(
                              children: [
                                //   Text("Selesai"),
                                //   Text("Terimakasih sudah mengisi pretest"),
                              ],
                            ),
                          )
                        : statuspostest == "buka"
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
                                          '${int.parse(v.datapostest?.response?[hasil].no ?? "")}.',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text:
                                                ' ${v.datapostest?.response?[hasil].soal ?? ""}?',
                                            style: TextStyle(
                                                wordSpacing: 1,
                                                fontWeight: FontWeight.normal)),
                                      ],
                                    ),
                                  ),
                                  // Text(
                                  //   '${v.datapostest?.response?[hasil].no}. ${v.datapostest?.response?[hasil].soal}?',
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
                                        loadingkirimpostest == false
                                            ? Center(
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      loadingkirimpostest =
                                                          true;
                                                      kirimSoal(
                                                          v
                                                              .datapostest!
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
                                                      loadingkirimpostest =
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
                            : statuspostest == "tutup"
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