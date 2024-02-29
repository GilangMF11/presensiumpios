import 'dart:ffi';

import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:attedancekaryawanump/views/provider/ramadhan/1444h/provideralquran.dart';
import 'package:attedancekaryawanump/views/ramadhan/1444h/persurahalquran.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

class MenuAlQuran extends StatefulWidget {
  const MenuAlQuran({Key? key}) : super(key: key);

  @override
  State<MenuAlQuran> createState() => _MenuAlQuranState();
}

class _MenuAlQuranState extends State<MenuAlQuran> {
  ArabicNumbers arabicNumber = ArabicNumbers();
  bool? loading = true;

  getDataAlquran() async {
    final providerrekap = Provider.of<ProviderAlQuran>(context, listen: false);
    await providerrekap.getAlQuranSurah();
    setState(() {
      loading = providerrekap.loading;
    });
  }

  // getDataGelombang() async {
  //   final providerrekap = Provider.of<ProviderAlQuran>(context, listen: false);
  //   await providerrekap.getAlQuranSurah();
  //   setState(() {
  //     loading = providerrekap.loading;
  //   });
  // }

  @override
  void initState() {
    getDataAlquran();
    // getDataGelombang();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderAlQuran>(builder: (context, v, child) {
      return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Color(0xFF191917),
            title: Text("Baca Al Qur'an"),
          ),
          body: loading == true
              ? Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFF1d8b61),
                  ),
                )
              : Container(
                  height: MediaQuery.of(context).size.height,
                  color: Color(0xFF191917),
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(top: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          for (var i = 0; i < v.dataSurah!.data!.length; i++)
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Persurah(
                                            nomor: v.dataSurah!.data![i].nomor,
                                          )),
                                );
                              },
                              child: CardMenuSurah(
                                number: v.dataSurah!.data![i].nomor.toString(),
                                namasurah: v.dataSurah!.data![i].namaLatin,
                                jumalahayat:
                                    v.dataSurah!.data![i].jumlahAyat.toString(),
                                tempatturunayat:
                                    v.dataSurah!.data![i].tempatTurun,
                                namasuraharab: v.dataSurah!.data![i].nama,
                                url: v.dataSurah!.data![i].audioFull?.s01,
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                ));
    });
  }
}

class CardMenuSurah extends StatefulWidget {
  String? number;
  String? namasurah;
  String? jumalahayat;
  String? tempatturunayat;
  String? namasuraharab;
  String? url;
  CardMenuSurah(
      {this.number,
      this.namasurah,
      this.jumalahayat,
      this.tempatturunayat,
      this.namasuraharab,
      this.url});

  @override
  State<CardMenuSurah> createState() => _CardMenuSurahState();
}

class _CardMenuSurahState extends State<CardMenuSurah> {
  final player = AudioPlayer();
  bool? play = false;

  playA() async {
    setState(() {
      play = true;
    });
    print(widget.url);
    await player.setUrl("${widget.url}");
    player.play();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.all(1.7),
                width: 43,
                height: 43,
                decoration: BoxDecoration(
                    color: Color(0xFFA67C00), shape: BoxShape.circle),
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xFF191917), shape: BoxShape.circle),
                  child: Center(
                    child: Text(
                      widget.number ?? "",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Color(0xFF1d8b61), fontSize: 15),
                    ),
                  ),
                ),
              )),
          Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.namasurah ?? "",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                        fontWeight: FontWeight.normal),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        "${widget.tempatturunayat}".toUpperCase(),
                        textAlign: TextAlign.right,
                        style:
                            TextStyle(color: Color(0xFFA67C00), fontSize: 13),
                      ),
                      Text(
                        " | ",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xFFA67C00),
                        ),
                      ),
                      Text(
                        " ${widget.jumalahayat} Ayat",
                        textAlign: TextAlign.right,
                        style:
                            TextStyle(color: Color(0xFFA67C00), fontSize: 13),
                      ),
                    ],
                  ),
                ],
              )),
          Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    widget.namasuraharab ?? "",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )),
          Expanded(
              flex: 2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Text("Play",
                  //     textAlign: TextAlign.right,
                  //     style: TextStyle(
                  //       color: Colors.white70,
                  //       fontSize: 12,
                  //     )),
                  Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: play == false
                          ? InkWell(
                              onTap: () async {
                                playA();
                              },
                              child: Icon(
                                Icons.play_arrow,
                                color: Color(0xFF1d8b61),
                                size: 25,
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                player.pause();
                                setState(() {
                                  play = false;
                                });
                              },
                              child: Icon(
                                Icons.stop,
                                color: Color(0xFF1d8b61),
                                size: 25,
                              ),
                            )),
                ],
              )),
        ],
      ),
    );
  }
}
