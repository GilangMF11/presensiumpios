import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:attedancekaryawanump/views/provider/ramadhan/1444h/provideralquran.dart';
import 'package:attedancekaryawanump/views/ramadhan/1444h/detailimsyakiyah.dart';
import 'package:attedancekaryawanump/views/ramadhan/1444h/doahariandetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DoaHarian extends StatefulWidget {
  @override
  State<DoaHarian> createState() => _DoaHarianState();
}

class _DoaHarianState extends State<DoaHarian> {
  bool? loading = true;
  getDataAlquran() async {
    final providerrekap = Provider.of<ProviderAlQuran>(context, listen: false);
    await providerrekap.getDoa();
    setState(() {
      loading = providerrekap.loadingdoa;
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
      return Scaffold(
          // backgroundColor: Color(0xFF191917),
          appBar: AppBar(
            title: Text("Doa Harian"),
            elevation: 0,
            backgroundColor: const Color(0xFF1d8b61),
          ),
          body: loading == true
              ? Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFF1d8b61),
                  ),
                )
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        for (var i = 0; i < v.dataDoa!.response!.length; i++)
                          CardRamadhan(
                            nama: v.dataDoa?.response?[i].doa,
                            nomor: i + 1,
                            icon: FlutterIslamicIcons.prayer,
                            ontap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      DoaHarianDetail(
                                        namadoa: v.dataDoa?.response?[i].doa,
                                        ayat: v.dataDoa?.response?[i].ayat,
                                        artinya:
                                            v.dataDoa?.response?[i].artinya,
                                        latin: v.dataDoa?.response?[i].latin,
                                      )));
                            },
                          )
                      ],
                    ),
                  ),
                ));
    });
  }
}

class CardRamadhan extends StatefulWidget {
  String? nama;
  IconData? icon;
  VoidCallback? ontap;
  int? nomor;
  CardRamadhan({this.nama, this.icon, this.ontap, this.nomor});

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
                color: Colors.white),
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
                                Icon(
                                  widget.icon,
                                  color: Colors.white,
                                  size: 25,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Doa",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15,
                                      color: Colors.white),
                                ),
                                // SizedBox(
                                //   height: 7,
                                // ),
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
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: const Color(0xFF1d8b61),
                                  ),
                                ),
                                // SizedBox(
                                //   height: 10,
                                // ),
                                // Text(
                                //   '',
                                //   maxLines: 2,
                                //   textAlign: TextAlign.center,
                                //   style: TextStyle(
                                //       fontWeight: FontWeight.normal,
                                //       fontSize: 15,
                                //       color: Colors.grey.shade400),
                                // ),
                                // Text(
                                //   '1444',
                                //   maxLines: 2,
                                //   textAlign: TextAlign.center,
                                //   style: TextStyle(
                                //       fontWeight: FontWeight.normal,
                                //       fontSize: 15,
                                //       color: Colors.white),
                                // ),
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
