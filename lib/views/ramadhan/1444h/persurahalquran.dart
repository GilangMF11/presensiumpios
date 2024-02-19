import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:attedancekaryawanump/views/provider/ramadhan/1444h/provideralquran.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:provider/provider.dart';

class Persurah extends StatefulWidget {
  int? nomor;
  Persurah({this.nomor});

  @override
  State<Persurah> createState() => _PersurahState();
}

class _PersurahState extends State<Persurah> {
  ArabicNumbers arabicNumber = ArabicNumbers();
  bool? loading = true;
  String? statusData;
  getDataAlquran() async {
    final providerrekap = Provider.of<ProviderAlQuran>(context, listen: false);
    await providerrekap.getAlQuran(widget.nomor);
    setState(() {
      loading = providerrekap.loadingsurah;
      statusData = providerrekap.statusData;
    });
  }

  @override
  void initState() {
    getDataAlquran();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderAlQuran>(builder: (context, v, child) {
      // print("data ${v.data!.data!.ayat!.length % 2}");
      return Scaffold(
          backgroundColor: Color(0xFF191917),
          appBar: AppBar(
            title: statusData == "tengah"
                ? Text(v.data?.data?.namaLatin ?? "")
                : statusData == "awal"
                    ? Text(v.dataAwal?.data?.namaLatin ?? "")
                    : statusData == "akhir"
                        ? Text(v.dataAkhir?.data?.namaLatin ?? "")
                        : Text(''),
            elevation: 0,
            backgroundColor: Color(0xFF191917),
          ),
          body: loading == true
              ? Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFF1d8b61),
                  ),
                )
              : Container(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (statusData == "tengah") ...[
                          for (var i = 0; i < v.data!.data!.ayat!.length; i++)
                            CardMenuSurah(
                                numberayat:
                                    v.data?.data?.ayat?[i].nomorAyat.toString(),
                                ayatbahasaarab:
                                    v.data?.data?.ayat?[i].teksArab.toString(),
                                latinarab: v.data?.data?.ayat?[i].teksLatin,
                                teksindonesia:
                                    v.data?.data?.ayat?[i].teksIndonesia,
                                colors: i % 2 == 0
                                    ? Color(0xFF1F2C33)
                                    : Color(0xFF191917)),
                        ] else if (statusData == "awal") ...[
                          for (var i = 0;
                              i < v.dataAwal!.data!.ayat!.length;
                              i++)
                            CardMenuSurah(
                                numberayat: v.dataAwal?.data?.ayat?[i].nomorAyat
                                    .toString(),
                                ayatbahasaarab: v
                                    .dataAwal?.data?.ayat?[i].teksArab
                                    .toString(),
                                latinarab: v.dataAwal?.data?.ayat?[i].teksLatin,
                                teksindonesia:
                                    v.dataAwal?.data?.ayat?[i].teksIndonesia,
                                colors: i % 2 == 0
                                    ? Color(0xFF1F2C33)
                                    : Color(0xFF191917)),
                        ] else if (statusData == "akhir") ...[
                          for (var i = 0;
                              i < v.dataAkhir!.data!.ayat!.length;
                              i++)
                            CardMenuSurah(
                                numberayat: v
                                    .dataAkhir?.data?.ayat?[i].nomorAyat
                                    .toString(),
                                ayatbahasaarab: v
                                    .dataAkhir?.data?.ayat?[i].teksArab
                                    .toString(),
                                latinarab:
                                    v.dataAkhir?.data?.ayat?[i].teksLatin,
                                teksindonesia:
                                    v.dataAkhir?.data?.ayat?[i].teksIndonesia,
                                colors: i % 2 == 0
                                    ? Color(0xFF1F2C33)
                                    : Color(0xFF191917))
                        ]
                        // if (v.data!.data!.ayat!.isNotEmpty)
                        //   for (var i = 0; i < v.data!.data!.ayat!.length; i++)
                        //     CardMenuSurah(
                        //       numberayat:
                        //           v.data?.data?.ayat?[i].nomorAyat.toString(),
                        //       ayatbahasaarab:
                        //           v.data?.data?.ayat?[i].teksArab.toString(),
                        //       latinarab: v.data?.data?.ayat?[i].teksLatin,
                        //       teksindonesia:
                        //           v.data?.data?.ayat?[i].teksIndonesia,
                        //     ),
                        // if (v.dataAwal!.data!.ayat!.isNotEmpty)
                        //   for (var i = 0;
                        //       i < v.dataAwal!.data!.ayat!.length;
                        //       i++)
                        //     CardMenuSurah(
                        //       numberayat: v.dataAwal?.data?.ayat?[i].nomorAyat
                        //           .toString(),
                        //       ayatbahasaarab: v
                        //           .dataAwal?.data?.ayat?[i].teksArab
                        //           .toString(),
                        //       latinarab: v.dataAwal?.data?.ayat?[i].teksLatin,
                        //       teksindonesia:
                        //           v.dataAwal?.data?.ayat?[i].teksIndonesia,
                        //     ),
                        // if (v.dataAkhir!.data!.ayat!.isNotEmpty)
                        //   for (var i = 0;
                        //       i < v.dataAkhir!.data!.ayat!.length;
                        //       i++)
                        //     CardMenuSurah(
                        //       numberayat: v.dataAkhir?.data?.ayat?[i].nomorAyat
                        //           .toString(),
                        //       ayatbahasaarab: v
                        //           .dataAkhir?.data?.ayat?[i].teksArab
                        //           .toString(),
                        //       latinarab: v.dataAkhir?.data?.ayat?[i].teksLatin,
                        //       teksindonesia:
                        //           v.dataAkhir?.data?.ayat?[i].teksIndonesia,
                        //     )
                      ],
                    ),
                  ),
                ));
    });
  }
}

class CardMenuSurah extends StatefulWidget {
  String? numberayat;
  String? ayatbahasaarab;
  String? latinarab;
  String? teksindonesia;
  String? numberayatarab;
  Color? colors;
  CardMenuSurah(
      {this.numberayat,
      this.ayatbahasaarab,
      this.latinarab,
      this.teksindonesia,
      this.numberayatarab,
      this.colors});

  @override
  State<CardMenuSurah> createState() => _CardMenuSurahState();
}

class _CardMenuSurahState extends State<CardMenuSurah> {
  ArabicNumbers arabicNumber = ArabicNumbers();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          bottom: 20,
          top: 20,
          left: MediaQuery.of(context).size.width * 0.02,
          right: MediaQuery.of(context).size.width * 0.02),
      decoration: BoxDecoration(
        color: widget.colors,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(1.7),
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                    color: Color(0xFFA67C00), shape: BoxShape.circle),
                child: Container(
                  decoration: BoxDecoration(
                      color: widget.colors, shape: BoxShape.circle),
                  child: Center(
                    child: Text(
                      widget.numberayat ?? "",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Color(0xFF1d8b61), fontSize: 15),
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.85,
                child: Text(
                  "${widget.ayatbahasaarab}  {${arabicNumber.convert(widget.numberayat)}} ",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 23,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(1.7),
                width: 40,
                height: 40,
                color: widget.colors,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.80,
                child: Text(
                  widget.latinarab ?? "",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Color(0xFF1d8b61),
                      fontSize: 18,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(1.7),
                width: 40,
                height: 40,
                color: widget.colors,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.80,
                child: Text(
                  widget.teksindonesia ?? "",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
