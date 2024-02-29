import 'package:attedancekaryawanump/views/provider/ramadhan/1445h/providerRamadhan1445.dart';
import 'package:attedancekaryawanump/views/ramadhan/1444h/doaharian.dart';
import 'package:attedancekaryawanump/views/ramadhan/1444h/imsyakiyah.dart';
import 'package:attedancekaryawanump/views/ramadhan/1444h/menualquran.dart';
import 'package:attedancekaryawanump/views/ramadhan/1445h/posttest/v_posttest_ramadhan1445.dart';
import 'package:attedancekaryawanump/views/ramadhan/1445h/presensi/v_menu_prensensi_ramadhan1445.dart';
import 'package:attedancekaryawanump/views/ramadhan/1445h/pretest/v_pretest_ramadhan1445.dart';
import 'package:attedancekaryawanump/views/ramadhan/1445h/quisioner/v_evaluasi_quisoner1445.dart';
import 'package:attedancekaryawanump/views/ramadhan/1445h/sertifikat/v_sertifikat_ramadhan1445.dart';
import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:provider/provider.dart';

class Ramadhan1455 extends StatefulWidget {
  const Ramadhan1455({Key? key}) : super(key: key);

  @override
  State<Ramadhan1455> createState() => _Ramadhan1455State();
}

class _Ramadhan1455State extends State<Ramadhan1455> {
  bool? loading = true;
  String? status = "normal";

  getDataGelombang() async {
    final providerrekap =
        Provider.of<ProviderRamadhan1445>(context, listen: false);
    await providerrekap.getMenuBaik();
    setState(() {
      status = providerrekap.statusgel;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getDataGelombang();
    });

    // TODO: implement initState
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
            title: status == "normal"
                ? const Text('Ramadhan 1445')
                : status == "ITIKAF"
                    ? const Text('Ramadhan 1445')
                    : status == "BAIK"
                        ? const Text('Ramadhan 1445')
                        : status == null
                            ? const Text('Ramadhan')
                            : const Text(""),
          ),
          body: status == "normal"
              ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                            height: MediaQuery.of(context).size.height * 0.08,
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            // color: Colors.red,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: const Color(0xFF1d8b61),
                                )),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    height: double.infinity,
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                        color: Color(0xFF1d8b61),
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(5),
                                            topLeft: Radius.circular(5))),
                                    child: const Icon(
                                      FlutterIslamicIcons.drum2,
                                      color: Colors.white,
                                      size: 35,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 8,
                                  child: Container(
                                    height: double.infinity,
                                    width: double.infinity,
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          "Menu Al Qur'an",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15,
                                            color: Color(0xFF1d8b61),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.90,
                          width: MediaQuery.of(context).size.width,
                          child: SingleChildScrollView(
                              child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                CardRamadhan(
                                  nama: "Al Quran",
                                  deskripsi: "Kitab Suci",
                                  // warna: Color(0xFF0a4f8f),
                                  warna: Colors.white,
                                  icon: FlutterIslamicIcons.quran2,
                                  ontap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                const MenuAlQuran()));
                                  },
                                ),
                                CardRamadhan(
                                  nama: "Doa Harian",
                                  deskripsi: "Kumpulan Doa Harian",
                                  // warna: Color(0xFF0a4f8f),
                                  warna: Colors.white,
                                  icon: FlutterIslamicIcons.prayer,
                                  ontap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                DoaHarian()));
                                  },
                                ),
                              ],
                            ),
                          )),
                        ),
                      ],
                    ),
                  ),
                )
              : status == "BAIK"
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                margin: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                // color: Colors.red,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: const Color(0xFF1d8b61),
                                    )),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        height: double.infinity,
                                        width: double.infinity,
                                        decoration: const BoxDecoration(
                                            color: Color(0xFF1d8b61),
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(5),
                                                topLeft: Radius.circular(5))),
                                        child: const Icon(
                                          FlutterIslamicIcons.drum2,
                                          color: Colors.white,
                                          size: 35,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 8,
                                      child: Container(
                                        height: double.infinity,
                                        width: double.infinity,
                                        padding: const EdgeInsets.only(
                                            left: 5, right: 5),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              'Anda Terdaftar pada',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15,
                                                color: Color(0xFF1d8b61),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 1,
                                            ),
                                            Text(
                                              "${v.datagelombang?.response?[0].keterangan} Gelombang ${v.datagelombang?.response?[0].gelombang}",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                  color: Colors.red.shade800),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.90,
                              width: MediaQuery.of(context).size.width,
                              child: SingleChildScrollView(
                                  child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  children: [
                                    CardRamadhan(
                                      nama: "Presensi BAIK",
                                      deskripsi:
                                          "Kegiatan acara pelaksanaan BAIK",
                                      // warna: Color(0xFF0a4f8f),
                                      warna: Colors.white,
                                      icon: FlutterIslamicIcons.mosque,
                                      ontap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (BuildContext
                                                        context) =>
                                                    const MenuPresensiRamadhan1445()));
                                      },
                                    ),
                                    CardRamadhan(
                                      nama: "Pretest BAIK",
                                      deskripsi:
                                          "Kegiatan acara pelaksanaan BAIK",
                                      // warna: Color(0xFF0a4f8f),
                                      warna: Colors.white,
                                      icon: FlutterIslamicIcons.ramadan,
                                      ontap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                                builder: (BuildContext
                                                        context) =>
                                                    const PretestRamadhan1445()))
                                            .then((value) =>
                                                {getDataGelombang()});
                                        print("asd");
                                      },
                                    ),
                                    CardRamadhan(
                                      nama: "Posttest BAIK",
                                      deskripsi:
                                          "Kegiatan acara pelaksanaan BAIK",
                                      // warna: Color(0xFF0a4f8f),
                                      warna: Colors.white,
                                      icon: FlutterIslamicIcons.crescentMoon,
                                      ontap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (BuildContext
                                                        context) =>
                                                    const PosttestRamadhan1445()));
                                      },
                                    ),
                                    CardRamadhan(
                                      nama: "Evaluasi BAIK",
                                      deskripsi:
                                          "Kegiatan Evaluasi acara pelaksanaan BAIK",
                                      // warna: Color(0xFF0a4f8f),
                                      warna: Colors.white,
                                      icon: FlutterIslamicIcons.community,
                                      ontap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (BuildContext
                                                        context) =>
                                                    const EvaluasiQuisoner1445()));
                                        print("asd");
                                      },
                                    ),
                                    CardRamadhan(
                                      nama: "Sertifikat Itikaf",
                                      deskripsi:
                                          "Download Sertifikat Pelaksanaan Itikaf",
                                      // warna: Color(0xFF0a4f8f),
                                      warna: Colors.white,
                                      icon: FlutterIslamicIcons.crescentMoon,
                                      ontap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (BuildContext
                                                        context) =>
                                                    const SetifikatRamadhan1445()));
                                      },
                                    ),
                                    CardRamadhan(
                                      nama: "Al Quran",
                                      deskripsi: "Kitab Suci",
                                      // warna: Color(0xFF0a4f8f),
                                      warna: Colors.white,
                                      icon: FlutterIslamicIcons.quran2,
                                      ontap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        const MenuAlQuran()));
                                      },
                                    ),
                                    CardRamadhan(
                                      nama: "Doa Harian",
                                      deskripsi: "Kumpulan Doa Harian",
                                      // warna: Color(0xFF0a4f8f),
                                      warna: Colors.white,
                                      icon: FlutterIslamicIcons.prayer,
                                      ontap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        DoaHarian()));
                                      },
                                    ),
                                    CardRamadhan(
                                      nama: "Imsyakiyah",
                                      deskripsi: "Jadwal Imsyakiyah",
                                      // warna: Color(0xFF0a4f8f),
                                      warna: Colors.white,
                                      icon: FlutterIslamicIcons.sajadah,
                                      ontap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        Imsyakiyah()));
                                      },
                                    ),
                                    const SizedBox(
                                      height: 150,
                                    ),
                                  ],
                                ),
                              )),
                            ),
                          ],
                        ),
                      ),
                    )
                  : status == "ITIKAF"
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.08,
                                    width: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 5),
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 5),
                                    // color: Colors.red,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: const Color(0xFF1d8b61),
                                        )),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            height: double.infinity,
                                            width: double.infinity,
                                            decoration: const BoxDecoration(
                                                color: Color(0xFF1d8b61),
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(5),
                                                    topLeft:
                                                        Radius.circular(5))),
                                            child: const Icon(
                                              FlutterIslamicIcons.drum2,
                                              color: Colors.white,
                                              size: 35,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 8,
                                          child: Container(
                                            height: double.infinity,
                                            width: double.infinity,
                                            padding: const EdgeInsets.only(
                                                left: 5, right: 5),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Text(
                                                  'Anda Terdaftar pada',
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15,
                                                    color: Color(0xFF1d8b61),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 1,
                                                ),
                                                Text(
                                                  "${v.datagelombang?.response?[0].keterangan} Gelombang ${v.datagelombang?.response?[0].gelombang}",
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12,
                                                      color:
                                                          Colors.red.shade800),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.90,
                                  width: MediaQuery.of(context).size.width,
                                  child: SingleChildScrollView(
                                      child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Column(
                                      children: [
                                        CardRamadhan(
                                          nama: "Presensi Itikaf",
                                          deskripsi:
                                              "Kegiatan acara pelaksanaan BAIK",
                                          // warna: Color(0xFF0a4f8f),
                                          warna: Colors.white,
                                          icon: Icons.mosque,
                                          ontap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        const MenuPresensiRamadhan1445()));
                                          },
                                        ),
                                        CardRamadhan(
                                          nama: "Evaluasi Itikaf",
                                          deskripsi:
                                              "Kegiatan Evaluasi acara pelaksanaan Itikaf",
                                          // warna: Color(0xFF0a4f8f),
                                          warna: Colors.white,
                                          icon: FlutterIslamicIcons.community,
                                          ontap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        const EvaluasiQuisoner1445()));
                                            //print("asd");
                                          },
                                        ),
                                        CardRamadhan(
                                          nama: "Sertifikat Itikaf",
                                          deskripsi:
                                              "Download Sertifikat Pelaksanaan Itikaf",
                                          // warna: Color(0xFF0a4f8f),
                                          warna: Colors.white,
                                          icon:
                                              FlutterIslamicIcons.crescentMoon,
                                          ontap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        const SetifikatRamadhan1445()));
                                          },
                                        ),
                                        CardRamadhan(
                                          nama: "Al Quran",
                                          deskripsi: "Kitab Suci",
                                          // warna: Color(0xFF0a4f8f),
                                          warna: Colors.white,
                                          icon: FlutterIslamicIcons.quran2,
                                          ontap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        const MenuAlQuran()));
                                          },
                                        ),
                                        CardRamadhan(
                                          nama: "Doa Harian",
                                          deskripsi: "Kumpulan Doa Harian",
                                          // warna: Color(0xFF0a4f8f),
                                          warna: Colors.white,
                                          icon: FlutterIslamicIcons.prayer,
                                          ontap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        DoaHarian()));
                                          },
                                        ),
                                        CardRamadhan(
                                          nama: "Imsyakiyah",
                                          deskripsi: "Jadwal Imsyakiyah",
                                          // warna: Color(0xFF0a4f8f),
                                          warna: Colors.white,
                                          icon: FlutterIslamicIcons.sajadah,
                                          ontap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        Imsyakiyah()));
                                          },
                                        ),
                                        const SizedBox(
                                          height: 150,
                                        ),
                                      ],
                                    ),
                                  )),
                                ),
                              ],
                            ),
                          ),
                        )
                      : status == "MANDIRI"
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: SingleChildScrollView(
                                child: Column(),
                              ),
                            )
                          : status == "EKSTERNAL"
                              ? SizedBox(
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  child: SingleChildScrollView(
                                    child: Column(),
                                  ),
                                )
                              : status == null
                                  ? SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height,
                                      width: MediaQuery.of(context).size.width,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.08,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5,
                                                        horizontal: 5),
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5,
                                                        horizontal: 5),
                                                // color: Colors.red,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    border: Border.all(
                                                      color: const Color(
                                                          0xFF1d8b61),
                                                    )),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        height: double.infinity,
                                                        width: double.infinity,
                                                        decoration: const BoxDecoration(
                                                            color: Color(
                                                                0xFF1d8b61),
                                                            borderRadius: BorderRadius.only(
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        5),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        5))),
                                                        child: const Icon(
                                                          FlutterIslamicIcons
                                                              .drum2,
                                                          color: Colors.white,
                                                          size: 35,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 8,
                                                      child: Container(
                                                        height: double.infinity,
                                                        width: double.infinity,
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 5,
                                                                right: 5),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: const [
                                                             Text(
                                                              "Menu Al Qur'an",
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 15,
                                                                color: Color(
                                                                    0xFF1d8b61),
                                                              ),
                                                            ),
                                                             SizedBox(
                                                              height: 1,
                                                            ),
                                                             Text(
                                                              "",
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 12,
                                                                // color: Colors
                                                                //     .red.shade800
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.90,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: SingleChildScrollView(
                                                  child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: Column(
                                                  children: [
                                                    CardRamadhan(
                                                      nama: "Al Quran",
                                                      deskripsi: "Kitab Suci",
                                                      // warna: Color(0xFF0a4f8f),
                                                      warna: Colors.white,
                                                      icon: FlutterIslamicIcons
                                                          .quran2,
                                                      ontap: () {
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder: (BuildContext
                                                                        context) =>
                                                                    const MenuAlQuran()));
                                                      },
                                                    ),
                                                    CardRamadhan(
                                                      nama: "Doa Harian",
                                                      deskripsi:
                                                          "Kumpulan Doa Harian",
                                                      // warna: Color(0xFF0a4f8f),
                                                      warna: Colors.white,
                                                      icon: FlutterIslamicIcons
                                                          .prayer,
                                                      ontap: () {
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder: (BuildContext
                                                                        context) =>
                                                                    DoaHarian()));
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container());
    });
  }
}

class CardRamadhan extends StatefulWidget {
  String? nama;
  String? deskripsi;
  String? gambar;
  Color? warna;
  IconData? icon;
  VoidCallback? ontap;
  CardRamadhan(
      {this.nama,
      this.deskripsi,
      this.gambar,
      this.warna,
      this.icon,
      this.ontap});

  @override
  State<CardRamadhan> createState() => _CardRamadhanState();
}

class _CardRamadhanState extends State<CardRamadhan> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 7,
      ),
      child: InkWell(
        onTap: widget.ontap,
        child: AspectRatio(
          aspectRatio: 3.8 / 1,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  const BoxShadow(
                      color: Colors.black12,
                      blurRadius: 7.0,
                      offset: Offset(0.0, 0.75))
                ],
                borderRadius: BorderRadius.circular(15),
                border: Border.all(width: 0.1),
                // image: DecorationImage(
                //     image: AssetImage("assets/images/bgcard.png"),
                //     fit: BoxFit.cover)
                color: widget.warna),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 3.8 / 1,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment(1, 1),
                                  colors: <Color>[
                                    // Color(0xFF3591A4),
                                    // Color(0xFF3401A4),
                                    Color(0xFF1d8b61),
                                    Color(0xFF294E34),
                                  ], // Gradient from https://learnui.design/tools/gradient-generator.html
                                  tileMode: TileMode.clamp,
                                ),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                    topLeft: Radius.circular(15))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  widget.icon,
                                  color: Colors.white,
                                  size: 35,
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                const Text(
                                  'Ramadhan 1444',
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${widget.nama}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Color(0xFF1d8b61),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '${widget.deskripsi}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12,
                                      color: Colors.grey.shade400),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
