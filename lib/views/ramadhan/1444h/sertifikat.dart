import 'package:attedancekaryawanump/views/provider/ramadhan/1444h/provideralquran.dart';
import 'package:attedancekaryawanump/views/ramadhan/1444h/presensiramadhan.dart';
import 'package:attedancekaryawanump/views/ramadhan/1444h/rekappresensiramadhan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class Sertifikat extends StatefulWidget {
  const Sertifikat({Key? key}) : super(key: key);

  @override
  State<Sertifikat> createState() => _SertifikatState();
}

class _SertifikatState extends State<Sertifikat> {
  bool? loading = true;
  String? status;
  String? statussertifikat;
  getPegajian() async {
    final providerrekap = Provider.of<ProviderAlQuran>(context, listen: false);
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
    return Consumer<ProviderAlQuran>(builder: (context, v, child) {
      return Scaffold(
          // backgroundColor: Color(0xFFF7F4F0),
          backgroundColor: Color(0xFFFFFFFF),
          appBar: AppBar(
            backgroundColor: const Color(0xFF1d8b61),
            title: Text("Sertifikat"),
          ),
          body: loading == false
              ? Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
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
                                  Text(
                                    "::INFO::",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  statussertifikat == "tutup"
                                      ? Text("$status",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
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
                                                  padding: EdgeInsets.all(15),
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
                                                          offset: Offset(0,
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
                                  SizedBox(
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
              : Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFF1d8b61),
                  ),
                ));
    });
  }
}
