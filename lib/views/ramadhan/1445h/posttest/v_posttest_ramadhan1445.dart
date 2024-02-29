import 'package:attedancekaryawanump/views/provider/ramadhan/1445h/providerRamadhan1445.dart';
import 'package:attedancekaryawanump/views/ramadhan/1445h/posttest/v_posttest_selanjutnya1445.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PosttestRamadhan1445 extends StatefulWidget {
  const PosttestRamadhan1445({Key? key}) : super(key: key);

  @override
  State<PosttestRamadhan1445> createState() => _PosttestRamadhan1445State();
}

class _PosttestRamadhan1445State extends State<PosttestRamadhan1445> {
  int? jawaban;
  bool? loading = true;
  bool? loadingkirimpostest = false;
  String? statuspostest;

  getSoal() async {
    final providerrekap =
        Provider.of<ProviderRamadhan1445>(context, listen: false);
    await providerrekap.getSoalPos();
    setState(() {
      loading = providerrekap.loadingSoalPostest;
      statuspostest = providerrekap.statuspostest;
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
      Navigator.of(context)
          .push(MaterialPageRoute(
              builder: (BuildContext context) => PosttestSelanjutnya1445(
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
        loadingkirimpostest = false;
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
      if (statuspostest == "buka") {
        for (var i = 0; i < v.datapostest!.jawaban!.length; i++) {
          if (v.datapostest!.response![0].soalId ==
              v.datapostest!.jawaban![i].soalId) {
            int aa = int.parse(v.datapostest!.jawaban![i].pilId!);
            String bb = v.datapostest!.jawaban![i].pilJawaban!;
            soaljawbanid?.add(aa);
            soaljawbantext?.add(bb);
            print(aa);
          }
        }
      }
      return Scaffold(
          appBar: AppBar(
            title: const Text('Posttest'),
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
                  padding: const EdgeInsets.only(
                      top: 30, left: 30, right: 30, bottom: 10),
                  child: statuspostest == "buka"
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
                                    '${int.parse(v.datapostest?.response?.first.no ?? "")}.',
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          ' ${v.datapostest?.response?[0].soal}?',
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
                                  loadingkirimpostest == false
                                      ? Center(
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                loadingkirimpostest = true;
                                                kirimSoal(
                                                    v.datapostest!.response![0]
                                                        .soalId,
                                                    jawaban);
                                              });
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 15,
                                                      horizontal: 30),
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
                                                loadingkirimpostest = false;
                                              });
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 15,
                                                      horizontal: 30),
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
                      : statuspostest == "selesai"
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
                          : statuspostest == "tutup"
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
                                  children: const [
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
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}
