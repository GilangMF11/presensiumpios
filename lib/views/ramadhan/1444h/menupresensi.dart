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

class MenuPresensiRamadhan extends StatefulWidget {
  const MenuPresensiRamadhan({Key? key}) : super(key: key);

  @override
  State<MenuPresensiRamadhan> createState() => _MenuPresensiRamadhanState();
}

class _MenuPresensiRamadhanState extends State<MenuPresensiRamadhan> {
  bool? loading = true;
  String? statuspresensi;
  String? statuspresensiket;
  List? lisket;
  getPegajian() async {
    final providerrekap = Provider.of<ProviderAlQuran>(context, listen: false);
    await providerrekap.getPengajian();
    setState(() {
      statuspresensi = providerrekap.statuPresensiDibuka;
      statuspresensiket = providerrekap.statuPresensiKet;
    });
    print(statuspresensiket);
    if (statuspresensi == "tutup") {
      List<String> namesSplit = statuspresensiket!.split("#");
      lisket = [];
      for (var i = 0; i < namesSplit.length; i++) {
        // print(namesSplit[i]);
        setState(() {
          lisket?.add(namesSplit[i]);
        });
      }
      setState(() {
        loading = providerrekap.loadinggetpengajian;
      });
    } else if (statuspresensi == "buka") {
      setState(() {
        loading = providerrekap.loadinggetpengajian;
      });
    }

    // print("haloo ${lisket!.length}");
    // print("haloo ${lisket![0]}");
  }

  @override
  void initState() {
    getPegajian();
    // TODO: implement initState
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
            title: Text("Presensi"),
            actions: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RekapPresensiRamadhan()),
                  );
                },
                child: Row(
                  children: [
                    Icon(Icons.receipt_rounded),
                    SizedBox(
                      width: 1.w,
                    ),
                    Text('Rekap'),
                    SizedBox(
                      width: 1.w,
                    ),
                  ],
                ),
              )
            ],
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
                          child: statuspresensi == "buka"
                              ? SingleChildScrollView(
                                  child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Column(
                                    children: [
                                      for (var i = 0;
                                          i <
                                              v.datapresensiRamdhadan!.response!
                                                  .length;
                                          i++)
                                        CardRamadhan(
                                          nama: v.datapresensiRamdhadan
                                              ?.response?[i].kegiatan,
                                          deskripsi: v.datapresensiRamdhadan
                                              ?.response?[i].keterangan,
                                          // warna: Color(0xFF0a4f8f),
                                          warna: Colors.white,
                                          icon: FlutterIslamicIcons.kaaba,
                                          sesi: v.datapresensiRamdhadan
                                              ?.response?[i].sesi,
                                          ontap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        PresensiRamadhan(
                                                          materi_id: v
                                                              .datapresensiRamdhadan
                                                              ?.response?[i]
                                                              .materiId,
                                                          kegiatan: v
                                                              .datapresensiRamdhadan
                                                              ?.response?[i]
                                                              .kegiatan,
                                                          tanggale: v
                                                              .datapresensiRamdhadan
                                                              ?.response?[i]
                                                              .tanggale,
                                                          dari_jam: v
                                                              .datapresensiRamdhadan
                                                              ?.response?[i]
                                                              .dariJam,
                                                          sampai_jam: v
                                                              .datapresensiRamdhadan
                                                              ?.response?[i]
                                                              .sampaiJam,
                                                          pemateri: v
                                                              .datapresensiRamdhadan
                                                              ?.response?[i]
                                                              .pemateri,
                                                          keterangan: v
                                                              .datapresensiRamdhadan
                                                              ?.response?[i]
                                                              .keterangan,
                                                          radius_id: v
                                                              .datapresensiRamdhadan
                                                              ?.response?[i]
                                                              .radiusId,
                                                          tempat: v
                                                              .datapresensiRamdhadan
                                                              ?.response?[i]
                                                              .tempat,
                                                          lat: v
                                                              .datapresensiRamdhadan
                                                              ?.response?[i]
                                                              .lat,
                                                          long: v
                                                              .datapresensiRamdhadan
                                                              ?.response?[i]
                                                              .long,

                                                          // lat: "${-7.4123407}",
                                                          // long: "${109.2695224}",
                                                          radius: v
                                                              .datapresensiRamdhadan
                                                              ?.response?[i]
                                                              .radius,
                                                          // radius: "300",
                                                          hikmah: v
                                                              .datapresensiRamdhadan
                                                              ?.response?[i]
                                                              .hikmah,
                                                        )));
                                          },
                                        ),
                                      SizedBox(
                                        height: 150,
                                      ),
                                    ],
                                  ),
                                ))
                              : SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 15),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "::INFO::",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 18,
                                        ),
                                        Text('"Presensi Belum Di Buka"',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700)),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        for (var i = 0; i < lisket!.length; i++)
                                          Container(
                                            margin: EdgeInsets.only(bottom: 10),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 15, horizontal: 5),
                                            decoration: BoxDecoration(
                                                color: const Color(0xFF1d8b61),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Text(lisket?[i],
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white)),
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

class CardRamadhan extends StatefulWidget {
  String? nama;
  String? deskripsi;
  String? gambar;
  Color? warna;
  IconData? icon;
  VoidCallback? ontap;
  String? sesi;
  CardRamadhan(
      {this.nama,
      this.deskripsi,
      this.gambar,
      this.warna,
      this.icon,
      this.ontap,
      this.sesi});

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
                  BoxShadow(
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
                          flex: 2,
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            decoration: BoxDecoration(
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
                                // Icon(
                                //   widget.icon,
                                //   color: Colors.white,
                                //   size: 20,
                                // ),
                                // SizedBox(
                                //   height: 7,
                                // ),
                                Text(
                                  'SESI ${widget.sesi}',
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 8,
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
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: const Color(0xFF1d8b61),
                                  ),
                                ),
                                SizedBox(
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
