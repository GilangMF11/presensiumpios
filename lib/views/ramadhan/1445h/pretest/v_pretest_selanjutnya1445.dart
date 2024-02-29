import 'package:attedancekaryawanump/views/homedashboard.dart';
import 'package:attedancekaryawanump/views/provider/ramadhan/1445h/providerRamadhan1445.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PretestSelanjutnya1445 extends StatefulWidget {
  int? index;
  PretestSelanjutnya1445({required this.index});

  @override
  State<PretestSelanjutnya1445> createState() => _PretestSelanjutnya1445State();
}

class _PretestSelanjutnya1445State extends State<PretestSelanjutnya1445> {
  int? jawaban;
  bool? loading = true;
  String? statuspretest;
  bool? loadingkirimpretest = false;

  getSoal() async {
    int? hasil = widget.index! + 1;
    int? back = hasil;
    final providerrekap = Provider.of<ProviderRamadhan1445>(context, listen: false);
    await providerrekap.getSoalPretest();
    setState(() {
      statuspretest = providerrekap.statuspretest;
    });
    print(statuspretest);
    if (statuspretest == "tutup") {
      setState(() {
        loading = providerrekap.loadingSoalPretest;
      });
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => HomeDashboard()));
    }
    if (statuspretest == "selesai") {
      int count = 0;
      Navigator.of(context).popUntil((_) => count++ >= hasil);

      // Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(builder: (context) => SkorPretest()),
      //     (Route<dynamic> route) => false);
      // Navigator.of(context).push(
      //     MaterialPageRoute(builder: (BuildContext context) => SkoPreterPretest()));
      setState(() {
        loading = providerrekap.loadingSoalPretest;
      });
    } else if (statuspretest == "buka") {
      setState(() {
        loading = providerrekap.loadingSoalPretest;
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
        loadingkirimpretest = false;
      });
    } else if (jawaban != null) {
      final providerrekap =
          Provider.of<ProviderRamadhan1445>(context, listen: false);
      await providerrekap.kirimSoalPretestJawab(soalid, jawabanid);
      setState(() {
        loadingkirimpretest = providerrekap.kirimSoalPretest;
        statuspretest = providerrekap.statuspretest;
      });
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => PretestSelanjutnya1445(
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
        loadingkirimpretest = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    int? hasil = widget.index! + 1;
    print("jumlah index ${hasil}");

    return Consumer<ProviderRamadhan1445>(builder: (context, v, child) {
      // print("$hasil ${v.datapretest!.jawaban!.length}");
      soaljawbanid = [];
      soaljawbantext = [];
      print("idsoal = $hasil jawaban ${v.datapretest!.response!.length}");
      if (statuspretest == "buka") {
        if (hasil == v.datapretest!.response!.length) {
          statuspretest = "selesai";
          print("buka");
        } else if (hasil > v.datapretest!.response!.length) {
          print("lebih");
          statuspretest = "selesai";
        } else if (hasil < v.datapretest!.response!.length) {
          for (var i = 0; i < v.datapretest!.jawaban!.length; i++) {
            if (v.datapretest!.response![hasil].soalId ==
                v.datapretest!.jawaban![i].soalId) {
              int aa = int.parse(v.datapretest!.jawaban![i].pilId!);
              String bb = v.datapretest!.jawaban![i].pilJawaban!;
              soaljawbanid?.add(aa);
              soaljawbantext?.add(bb);
            }
          }
        }
      } else if (statuspretest == "selesai") {
        print("aaaaaaayaa");
      }
      return Scaffold(
          appBar: AppBar(
            title: Text('Pretest'),
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
                    child: statuspretest == "selesai"
                        ? Center(
                            child: Column(
                              children: [
                                //   Text("Selesai"),
                                //   Text("Terimakasih sudah mengisi pretest"),
                              ],
                            ),
                          )
                        : statuspretest == "buka"
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
                                          '${int.parse(v.datapretest?.response?[hasil].no ?? "")}.',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text:
                                                ' ${v.datapretest?.response?[hasil].soal ?? ""}?',
                                            style: TextStyle(
                                                wordSpacing: 1,
                                                fontWeight: FontWeight.normal)),
                                      ],
                                    ),
                                  ),
                                  // Text(
                                  //   '${v.datapretest?.response?[hasil].no}. ${v.datapretest?.response?[hasil].soal}?',
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
                                        loadingkirimpretest == false
                                            ? Center(
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      loadingkirimpretest =
                                                          true;
                                                      kirimSoal(
                                                          v
                                                              .datapretest!
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
                                                      loadingkirimpretest =
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
                            : statuspretest == "tutup"
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
