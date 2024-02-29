import 'package:attedancekaryawanump/views/provider/ramadhan/1445h/providerRamadhan1445.dart';
import 'package:attedancekaryawanump/views/ramadhan/1445h/pretest/v_pretest_selanjutnya1445.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PretestRamadhan1445 extends StatefulWidget {
  const PretestRamadhan1445({Key? key}) : super(key: key);

  @override
  State<PretestRamadhan1445> createState() => _PretestRamadhan1445State();
}

class _PretestRamadhan1445State extends State<PretestRamadhan1445> {
  int? jawaban;
  bool? loading = true;
  bool? loadingkirimpretest = false;
  String? statuspretest;

  getSoal() async {
    final providerrekap = Provider.of<ProviderRamadhan1445>(context, listen: false);
    await providerrekap.getSoalPretest();
    setState(() {
      loading = providerrekap.loadingSoalPretest;
      statuspretest = providerrekap.statuspretest;
    });
  }

  kirimSoal(String? soalid, int? jawabanid) async {
    if (jawaban == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red.shade600,
        content: const Text(
          "Anda belum memilih jawaban",
          style: TextStyle(color: Colors.white),
        ),
        duration: const Duration(seconds: 3),
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
      Navigator.of(context)
          .push(MaterialPageRoute(
              builder: (BuildContext context) => PretestSelanjutnya1445(
                    index: 0,
                  )))
          .then((value) => {getSoal()});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red.shade600,
        content: const Text(
          "Error",
          style: TextStyle(color: Colors.white),
        ),
        duration: const Duration(seconds: 3),
      ));
      setState(() {
        loadingkirimpretest = false;
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
    return Consumer<ProviderRamadhan1445>(builder: (context, v, child) {
      // List<int> _numbers = List<int>.generate(10, (index) => index);
      soaljawbanid = [];
      soaljawbantext = [];
      if (statuspretest == "buka") {
        for (var i = 0; i < v.datapretest!.jawaban!.length; i++) {
          if (v.datapretest!.response![0].soalId ==
              v.datapretest!.jawaban![i].soalId) {
            int aa = int.parse(v.datapretest!.jawaban![i].pilId!);
            String bb = v.datapretest!.jawaban![i].pilJawaban!;
            soaljawbanid?.add(aa);
            soaljawbantext?.add(bb);
            print(aa);
          }
        }
      }
      return Scaffold(
          appBar: AppBar(
            title: const Text('Pretest'),
            backgroundColor: const Color(0xFF1d8b61),
          ),
          body: loading == true
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFF1d8b61),
                  ),
                )
              : SingleChildScrollView(
                  child: Padding(
                  padding:
                      const EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 10),
                  child: statuspretest == "buka"
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Center(
                                child: Padding(
                              padding: EdgeInsets.only(
                                  left: 3, right: 3, bottom: 10),
                              child: Text(
                                'Pertanyaan',
                                style: TextStyle(fontSize: 16),
                              ),
                            )),
                            const SizedBox(
                              height: 20,
                            ),
                            RichText(
                              text: TextSpan(
                                text:
                                    '${int.parse(v.datapretest?.response?.first.no ?? "")}.',
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          ' ${v.datapretest?.response?[0].soal}?',
                                      style: const TextStyle(
                                          wordSpacing: 1,
                                          fontWeight: FontWeight.normal)),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
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
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  loadingkirimpretest == false
                                      ? Center(
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                loadingkirimpretest = true;
                                                kirimSoal(
                                                    v.datapretest!.response![0]
                                                        .soalId,
                                                    jawaban);
                                              });
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 15, horizontal: 30),
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFF1d8b61),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: const Text(
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
                                                loadingkirimpretest = false;
                                              });
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 15, horizontal: 30),
                                              decoration: BoxDecoration(
                                                  color: Colors.grey,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: const Text(
                                                'Loading',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : statuspretest == "selesai"
                          ? Center(
                              child: Column(
                                children: [
                                  const Text(
                                    "::Informasi::",
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(v.dataErrorPretest?.metaData?.pesan ??
                                      ""),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  const Text("Skornya :"),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text("${v.skor}",
                                      style: const TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            )
                          : statuspretest == "tutup"
                              ? Center(
                                  child: Column(
                                    children: [
                                      const Text(
                                        "::Informasi::",
                                        style: TextStyle(fontSize: 17),
                                      ),
                                      const SizedBox(
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
                                    const Text(
                                      "::Informasi::",
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text("Error"),
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
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}