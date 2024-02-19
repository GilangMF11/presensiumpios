import 'package:attedancekaryawanump/views/model/modelevaluasiquisioner.dart';
import 'package:attedancekaryawanump/views/provider/ramadhan/1444h/provideralquran.dart';
import 'package:attedancekaryawanump/views/ramadhan/1444h/amalia_pages.dart';
import 'package:attedancekaryawanump/views/ramadhan/1444h/evaluasiqusionerselanjutnya.dart';
import 'package:attedancekaryawanump/views/ramadhan/1444h/pretestselanjutnya.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class EvaluasiQusioner extends StatefulWidget {
  const EvaluasiQusioner({Key? key}) : super(key: key);

  @override
  State<EvaluasiQusioner> createState() => _EvaluasiQusionerState();
}

class _EvaluasiQusionerState extends State<EvaluasiQusioner> {
  int? jawaban;
  bool? loading = true;
  bool? loadingkirimquisioner = false;
  String? statusqusioner;

  getSoal() async {
    final providerrekap = Provider.of<ProviderAlQuran>(context, listen: false);
    await providerrekap.getEvaluasiQusioner();
    setState(() {
      loading = providerrekap.loadingquisioner;
      statusqusioner = providerrekap.statusquisioner;
    });
  }

  kirimSoal(String? soalid, int? jawabanid) async {
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
      Navigator.of(context)
          .push(MaterialPageRoute(
              builder: (BuildContext context) => EvaluasiQuisionerSelanjutnya(
                    index: 0,
                  )))
          .then((value) => {getSoal()});
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

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await getSoal();
    });
    // TODO: implement initState
    super.initState();
  }

  List<int>? soaljawbanid = [];
  List<String>? soaljawbantext = [];
  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderAlQuran>(builder: (context, v, child) {
      // List<int> _numbers = List<int>.generate(10, (index) => index);
      soaljawbanid = [];
      soaljawbantext = [];
      if (statusqusioner == "buka") {
        for (var i = 0; i < 5; i++) {
          // if (v.dataquisioner!.response![0].soalId ==
          //     v.dataquisioner!.jawaban![i].pilId) {
          int aa = int.parse(v.dataquisioner!.jawaban![i].pilId!);
          String bb = v.dataquisioner!.jawaban![i].pilJawaban!;
          soaljawbanid?.add(aa);
          soaljawbantext?.add(bb);
          print(aa);
          // }
        }
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
                  padding:
                      EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 10),
                  child: statusqusioner == "buka"
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
                                    '${int.parse(v.dataquisioner?.response?.first.no ?? "")}.',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          ' ${v.dataquisioner?.response?[0].soal}?',
                                      style: TextStyle(
                                          wordSpacing: 1,
                                          fontWeight: FontWeight.normal)),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 50),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (int i = 0; i < soaljawbanid!.length; i++)
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
                                                loadingkirimquisioner = true;
                                                kirimSoal(
                                                    v.dataquisioner!
                                                        .response![0].soalId,
                                                    jawaban);
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 15, horizontal: 30),
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFF1d8b61),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
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
                                                loadingkirimquisioner = false;
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 15, horizontal: 30),
                                              decoration: BoxDecoration(
                                                  color: Colors.grey,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
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
                      : statusqusioner == "selesai"
                          ? Center(
                              child: Column(
                                children: [
                                  Text(
                                    "::Sudah Selesai::",
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  // Text(v.dataErrorPretest?.metaData?.pesan ??
                                  //     ""),
                                  // SizedBox(
                                  //   height: 40,
                                  // ),
                                  // Text("Skornya :"),
                                  // SizedBox(
                                  //   height: 20,
                                  // ),
                                  // Text("${v.skor}",
                                  //     style: TextStyle(
                                  //         fontSize: 40,
                                  //         fontWeight: FontWeight.bold)),
                                ],
                              ),
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
                                      Text(
                                          v.dataErrorPretest?.metaData?.pesan ??
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
                )));
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
