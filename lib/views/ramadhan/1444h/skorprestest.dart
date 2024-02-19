import 'package:attedancekaryawanump/views/homedashboard.dart';
import 'package:attedancekaryawanump/views/provider/ramadhan/1444h/provideralquran.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class SkorPretest extends StatefulWidget {
  const SkorPretest({Key? key}) : super(key: key);

  @override
  State<SkorPretest> createState() => _SkorPretestState();
}

class _SkorPretestState extends State<SkorPretest> {
  int? jawaban;
  bool? loading = true;
  bool? loadingkirimpretest = false;
  String? statuspretest;

  getSoal() async {
    final providerrekap = Provider.of<ProviderAlQuran>(context, listen: false);
    await providerrekap.getSoalPretest();
    setState(() {
      loading = providerrekap.loadingSoalPretest;
      statuspretest = providerrekap.statuspretest;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      getSoal();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderAlQuran>(builder: (context, v, child) {
      return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text('Selesai'),
            backgroundColor: const Color(0xFF1d8b61),
            centerTitle: true,
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
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              "::Informasi::",
                              style: TextStyle(fontSize: 17),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(v.dataErrorPretest?.metaData?.pesan ?? ""),
                            SizedBox(
                              height: 40,
                            ),
                            Text("Skornya :"),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Text("${v.skor}",
                                style: TextStyle(
                                    fontSize: 40, fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 50,
                            ),
                            Center(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HomeDashboard()),
                                        (Route<dynamic> route) => false);
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 40),
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF1d8b61),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    'Back Home',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ))));
    });
  }
}
