import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DoaHarianDetail extends StatefulWidget {
  String? namadoa;
  String? ayat;
  String? latin;
  String? artinya;

  DoaHarianDetail({Key? key, this.namadoa, this.ayat, this.latin, this.artinya})
      : super(key: key);

  @override
  State<DoaHarianDetail> createState() => _DoaHarianDetailState();
}

class _DoaHarianDetailState extends State<DoaHarianDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF191917),
      appBar: AppBar(
        title: Text(widget.namadoa ?? ""),
        elevation: 0,
        backgroundColor: const Color(0xFF191917),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
            child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: CardMenuSurah(
            ayat: widget.ayat,
            latin: widget.latin,
            terjemah: widget.artinya,
            colors: Color(0xFF1F2C33),
          ),
        )),
      ),
    );
  }
}

class CardMenuSurah extends StatefulWidget {
  String? ayat;
  String? latin;
  String? terjemah;
  Color? colors;
  CardMenuSurah({this.ayat, this.latin, this.terjemah, this.colors});

  @override
  State<CardMenuSurah> createState() => _CardMenuSurahState();
}

class _CardMenuSurahState extends State<CardMenuSurah> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          bottom: 20,
          top: 20,
          left: MediaQuery.of(context).size.width * 0.02,
          right: MediaQuery.of(context).size.width * 0.02),
      decoration: BoxDecoration(
          color: widget.colors, borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.90,
              child: Text(
                widget.ayat ?? "",
                textAlign: TextAlign.right,
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: 23,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              "Latin",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Color(0xFF1d8b61),
                  fontSize: 18,
                  fontWeight: FontWeight.normal),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              widget.latin ?? "",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Color(0xFF1d8b61),
                  fontSize: 18,
                  fontWeight: FontWeight.normal),
            ),
          ),
          SizedBox(
            height: 35,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              "Terjemah",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                  fontWeight: FontWeight.normal),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              widget.terjemah ?? "",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ],
      ),
    );
  }
}
