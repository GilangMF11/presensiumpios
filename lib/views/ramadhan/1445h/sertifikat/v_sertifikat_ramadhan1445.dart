import 'package:attedancekaryawanump/views/provider/ramadhan/1445h/providerRamadhan1445.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class SetifikatRamadhan1445 extends StatefulWidget {
  const SetifikatRamadhan1445({Key? key}) : super(key: key);

  @override
  State<SetifikatRamadhan1445> createState() => _SetifikatRamadhan1445State();
}

class _SetifikatRamadhan1445State extends State<SetifikatRamadhan1445> {
  bool? loading = true;
  String? status;
  String? statussertifikat;
  getPegajian() async {
    final providerrekap = Provider.of<ProviderRamadhan1445>(context, listen: false);
    await providerrekap.getSertifikat();
    setState(() {
      status = providerrekap.link;
      statussertifikat = providerrekap.statussertifikat;
      loading = providerrekap.loadingsertifikat;
    });
  }

  @override
  void initState() {
    getPegajian();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderRamadhan1445>(builder: (context, v, child) {
      return Scaffold(
          // backgroundColor: Color(0xFFF7F4F0),
          backgroundColor: const Color(0xFFFFFFFF),
          appBar: AppBar(
            backgroundColor: const Color(0xFF1d8b61),
            title: const Text("Sertifikat"),
          ),
          body: loading == false
              ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    "::INFO::",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  statussertifikat == "tutup"
                                      ? Text("$status",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700))
                                      : Column(
                                          children: [
                                            Text(
                                                'Download Sertifikat Klik Tombol Dibawah ini',
                                                style: TextStyle(
                                                    fontSize: 11.sp,
                                                    color: Colors.black54)),
                                            InkWell(
                                              onTap: () async {
                                                await launchUrl(
                                                    Uri.parse('$status'),
                                                    mode: LaunchMode
                                                        .externalApplication);
                                              },
                                              child: Container(
                                                  padding: const EdgeInsets.all(15),
                                                  alignment: Alignment.center,
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 6.w,
                                                      vertical: 6.w),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: const Color(
                                                          0xFF1d8b61),
                                                      // color: Color(0xFF345DA7),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.1),
                                                          spreadRadius: 0.5,
                                                          blurRadius: 2,
                                                          offset: const Offset(0,
                                                              3), // changes position of shadow
                                                        )
                                                      ]),
                                                  child: Text(
                                                      'Download Sertifikat',
                                                      style: TextStyle(
                                                          fontSize: 11.sp,
                                                          color:
                                                              Colors.white))),
                                            ),
                                          ],
                                        ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFF1d8b61),
                  ),
                ));
    });
  }
}