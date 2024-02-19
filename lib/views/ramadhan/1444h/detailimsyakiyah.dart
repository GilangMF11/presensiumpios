import 'package:attedancekaryawanump/views/provider/ramadhan/1444h/provideralquran.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DetailImsyakiyah extends StatefulWidget {
  String? date;
  DetailImsyakiyah({Key? key, this.date}) : super(key: key);

  @override
  State<DetailImsyakiyah> createState() => _DetailImsyakiyahState();
}

class _DetailImsyakiyahState extends State<DetailImsyakiyah> {
  bool? loading = true;
  getDataAlquran() async {
    print("halooo ${widget.date}");
    final providerrekap = Provider.of<ProviderAlQuran>(context, listen: false);
    await providerrekap.getImsyakiyah(widget.date);
    setState(() {
      loading = providerrekap.loadingimsyakiyah;
    });
  }

  @override
  void initState() {
    getDataAlquran();
    // TODO: implement initState
    super.initState();
  }

  dateConvertTanggal(date) {
    // print(date);
    // String? convertdate = date.toString().replaceAll("/", "");
    // String? dd = convertdate.substring(0, 2);
    // print(dd);
    // String? mm = convertdate.substring(2, 4);
    // print(mm);
    // String? yy = convertdate.substring(4, 8);
    // print(yy);
    // String? hasil = "$yy-$mm-$dd";
    // print(hasil);
    // DateTime parseDate = DateFormat("yyyy-MM-dd").parse(hasil);
    DateTime parseDate = DateFormat("yyyy-MM-dd").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    // var outputFormat = DateFormat('MM/dd/yyyy');
    var outputFormat2 = DateFormat('yyyy/MM/dd');
    var outputFormat3 = DateFormat.yMMMMd('id');
    var outputDate = outputFormat3.format(inputDate);
    return outputDate;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderAlQuran>(builder: (context, v, child) {
      return Scaffold(
          backgroundColor: Color(0xFF191917),
          appBar: AppBar(
            title: Text(
              "Jadwal Imsyakyah",
              style: TextStyle(
                color: Colors.white70,
              ),
            ),
            elevation: 0,
            // backgroundColor: const Color(0xFF1d8b61),
            backgroundColor: Color(0xFF191917),
          ),
          body: loading == true
              ? Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFF1d8b61),
                  ),
                )
              : Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Color(0xFF191917),
                    // color: Colors.grey.shade100
                  ),
                  child: SingleChildScrollView(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          "Jadwal Imsak",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 33,
                              color: Colors.white70),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 5),
                      //   child: Text(
                      //     ",
                      //     style: TextStyle(
                      //         fontWeight: FontWeight.bold,
                      //         fontSize: 33,
                      //         color: Colors.black87),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          "${v.dataimsyakya?.response?.tanggal.toString().substring(0, 5)} ${dateConvertTanggal(widget.date)}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xFFA67C00),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      // Row(
                      //   children: [
                      //     Expanded(
                      //       flex: 5,
                      //       child: Column(
                      //         children: [
                      //           Container(
                      //             width:
                      //                 MediaQuery.of(context).size.width * 0.50,
                      //             height: 200,
                      //             padding: EdgeInsets.symmetric(
                      //                 horizontal: 10, vertical: 10),
                      //             decoration: BoxDecoration(
                      //               color: Colors.white,
                      //               borderRadius: BorderRadius.circular(10),
                      //               boxShadow: [
                      //                 BoxShadow(
                      //                   color: Colors.grey.withOpacity(0.5),
                      //                   spreadRadius: 0.5,
                      //                   blurRadius: 2,
                      //                   offset: Offset(
                      //                       0, 3), // changes position of shadow
                      //                 )
                      //               ],
                      //             ),
                      //             child: Column(
                      //               mainAxisAlignment: MainAxisAlignment.center,
                      //               crossAxisAlignment:
                      //                   CrossAxisAlignment.center,
                      //               children: [
                      //                 Padding(
                      //                   padding: EdgeInsets.only(top: 10),
                      //                   child: Text(
                      //                     "Buka Puasa",
                      //                     style: TextStyle(
                      //                         fontWeight: FontWeight.bold,
                      //                         fontSize: 17,
                      //                         color: Colors.black87),
                      //                   ),
                      //                 ),
                      //                 SizedBox(
                      //                   height: 20,
                      //                 ),
                      //                 Padding(
                      //                   padding: const EdgeInsets.only(top: 5),
                      //                   child: Text(
                      //                     v.dataimsyakya?.response?.maghrib ??
                      //                         "",
                      //                     style: TextStyle(
                      //                         fontWeight: FontWeight.bold,
                      //                         fontSize: 26,
                      //                         color: Colors.black87),
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //           SizedBox(
                      //             height: 20,
                      //           ),
                      //           Container(
                      //             width:
                      //                 MediaQuery.of(context).size.width * 0.50,
                      //             height: 200,
                      //             padding: EdgeInsets.symmetric(
                      //                 horizontal: 10, vertical: 10),
                      //             decoration: BoxDecoration(
                      //               color: Colors.white,
                      //               borderRadius: BorderRadius.circular(10),
                      //               boxShadow: [
                      //                 BoxShadow(
                      //                   color: Colors.grey.withOpacity(0.5),
                      //                   spreadRadius: 0.5,
                      //                   blurRadius: 2,
                      //                   offset: Offset(
                      //                       0, 3), // changes position of shadow
                      //                 )
                      //               ],
                      //             ),
                      //             child: Column(
                      //               mainAxisAlignment: MainAxisAlignment.center,
                      //               crossAxisAlignment:
                      //                   CrossAxisAlignment.center,
                      //               children: [
                      //                 Padding(
                      //                   padding: EdgeInsets.only(top: 10),
                      //                   child: Text(
                      //                     "Imsak",
                      //                     style: TextStyle(
                      //                         fontWeight: FontWeight.bold,
                      //                         fontSize: 17,
                      //                         color: Colors.black87),
                      //                   ),
                      //                 ),
                      //                 SizedBox(
                      //                   height: 20,
                      //                 ),
                      //                 Padding(
                      //                   padding: const EdgeInsets.only(top: 5),
                      //                   child: Text(
                      //                     v.dataimsyakya?.response?.imsak ?? "",
                      //                     style: TextStyle(
                      //                         fontWeight: FontWeight.bold,
                      //                         fontSize: 26,
                      //                         color: Colors.black87),
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       width: 20,
                      //     ),
                      //     Expanded(
                      //       flex: 5,
                      //       child: Container(
                      //         width: MediaQuery.of(context).size.width * 0.50,
                      //         height: 420,
                      //         padding:
                      //             EdgeInsets.only(top: 0, left: 12, right: 12),
                      //         decoration: BoxDecoration(
                      //           color: Colors.white,
                      //           borderRadius: BorderRadius.circular(10),
                      //           boxShadow: [
                      //             BoxShadow(
                      //               color: Colors.grey.withOpacity(0.5),
                      //               spreadRadius: 0.5,
                      //               blurRadius: 2,
                      //               offset: Offset(
                      //                   0, 3), // changes position of shadow
                      //             )
                      //           ],
                      //         ),
                      //         child: Column(
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           crossAxisAlignment: CrossAxisAlignment.center,
                      //           children: [
                      //             Padding(
                      //               padding: EdgeInsets.only(top: 0),
                      //               child: Text(
                      //                 "Adzan",
                      //                 style: TextStyle(
                      //                     fontWeight: FontWeight.bold,
                      //                     fontSize: 26,
                      //                     color: Colors.black87),
                      //               ),
                      //             ),
                      //             SizedBox(
                      //               height: 20,
                      //             ),
                      //             Row(
                      //               children: [
                      //                 Expanded(
                      //                   flex: 5,
                      //                   child: Padding(
                      //                     padding: EdgeInsets.only(
                      //                       top: 10,
                      //                     ),
                      //                     child: Text(
                      //                       "Subuh",
                      //                       style: TextStyle(
                      //                         fontWeight: FontWeight.bold,
                      //                         fontSize: 15,
                      //                         color: Color(0xFF1d8b61),
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 SizedBox(
                      //                   width: 10,
                      //                 ),
                      //                 Expanded(
                      //                   flex: 5,
                      //                   child: Padding(
                      //                     padding:
                      //                         const EdgeInsets.only(top: 10),
                      //                     child: Text(
                      //                       v.dataimsyakya?.response?.subuh ??
                      //                           "",
                      //                       textAlign: TextAlign.end,
                      //                       style: TextStyle(
                      //                           fontWeight: FontWeight.bold,
                      //                           fontSize: 23,
                      //                           color: Colors.black87),
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //             Row(
                      //               children: [
                      //                 Expanded(
                      //                   flex: 5,
                      //                   child: Padding(
                      //                     padding: EdgeInsets.only(
                      //                       top: 10,
                      //                     ),
                      //                     child: Text(
                      //                       "Terbit",
                      //                       style: TextStyle(
                      //                         fontWeight: FontWeight.bold,
                      //                         fontSize: 15,
                      //                         color: Color(0xFF1d8b61),
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 SizedBox(
                      //                   width: 10,
                      //                 ),
                      //                 Expanded(
                      //                   flex: 5,
                      //                   child: Padding(
                      //                     padding:
                      //                         const EdgeInsets.only(top: 10),
                      //                     child: Text(
                      //                       v.dataimsyakya?.response?.terbit ??
                      //                           "",
                      //                       textAlign: TextAlign.end,
                      //                       style: TextStyle(
                      //                           fontWeight: FontWeight.bold,
                      //                           fontSize: 23,
                      //                           color: Colors.black87),
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //             Row(
                      //               children: [
                      //                 Expanded(
                      //                   flex: 5,
                      //                   child: Padding(
                      //                     padding: EdgeInsets.only(
                      //                       top: 10,
                      //                     ),
                      //                     child: Text(
                      //                       "Dhuha",
                      //                       style: TextStyle(
                      //                         fontWeight: FontWeight.bold,
                      //                         fontSize: 15,
                      //                         color: Color(0xFF1d8b61),
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 SizedBox(
                      //                   width: 10,
                      //                 ),
                      //                 Expanded(
                      //                   flex: 5,
                      //                   child: Padding(
                      //                     padding:
                      //                         const EdgeInsets.only(top: 10),
                      //                     child: Text(
                      //                       v.dataimsyakya?.response?.dhuha ??
                      //                           "",
                      //                       textAlign: TextAlign.end,
                      //                       style: TextStyle(
                      //                           fontWeight: FontWeight.bold,
                      //                           fontSize: 23,
                      //                           color: Colors.black87),
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //             Row(
                      //               children: [
                      //                 Expanded(
                      //                   flex: 5,
                      //                   child: Padding(
                      //                     padding: EdgeInsets.only(
                      //                       top: 10,
                      //                     ),
                      //                     child: Text(
                      //                       "Dzuhur",
                      //                       style: TextStyle(
                      //                         fontWeight: FontWeight.bold,
                      //                         fontSize: 15,
                      //                         color: Color(0xFF1d8b61),
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 SizedBox(
                      //                   width: 10,
                      //                 ),
                      //                 Expanded(
                      //                   flex: 5,
                      //                   child: Padding(
                      //                     padding:
                      //                         const EdgeInsets.only(top: 10),
                      //                     child: Text(
                      //                       v.dataimsyakya?.response?.dzuhur ??
                      //                           "",
                      //                       textAlign: TextAlign.end,
                      //                       style: TextStyle(
                      //                           fontWeight: FontWeight.bold,
                      //                           fontSize: 23,
                      //                           color: Colors.black87),
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //             Row(
                      //               children: [
                      //                 Expanded(
                      //                   flex: 5,
                      //                   child: Padding(
                      //                     padding: EdgeInsets.only(
                      //                       top: 10,
                      //                     ),
                      //                     child: Text(
                      //                       "Ashar",
                      //                       style: TextStyle(
                      //                         fontWeight: FontWeight.bold,
                      //                         fontSize: 15,
                      //                         color: Color(0xFF1d8b61),
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 SizedBox(
                      //                   width: 10,
                      //                 ),
                      //                 Expanded(
                      //                   flex: 5,
                      //                   child: Padding(
                      //                     padding:
                      //                         const EdgeInsets.only(top: 10),
                      //                     child: Text(
                      //                       v.dataimsyakya?.response?.ashar ??
                      //                           "",
                      //                       textAlign: TextAlign.end,
                      //                       style: TextStyle(
                      //                           fontWeight: FontWeight.bold,
                      //                           fontSize: 23,
                      //                           color: Colors.black87),
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //             Row(
                      //               children: [
                      //                 Expanded(
                      //                   flex: 5,
                      //                   child: Padding(
                      //                     padding: EdgeInsets.only(
                      //                       top: 10,
                      //                     ),
                      //                     child: Text(
                      //                       "Maghrib",
                      //                       style: TextStyle(
                      //                         fontWeight: FontWeight.bold,
                      //                         fontSize: 15,
                      //                         color: Color(0xFF1d8b61),
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 SizedBox(
                      //                   width: 10,
                      //                 ),
                      //                 Expanded(
                      //                   flex: 5,
                      //                   child: Padding(
                      //                     padding:
                      //                         const EdgeInsets.only(top: 10),
                      //                     child: Text(
                      //                       v.dataimsyakya?.response?.maghrib ??
                      //                           "",
                      //                       textAlign: TextAlign.end,
                      //                       style: TextStyle(
                      //                           fontWeight: FontWeight.bold,
                      //                           fontSize: 23,
                      //                           color: Colors.black87),
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //             Row(
                      //               children: [
                      //                 Expanded(
                      //                   flex: 5,
                      //                   child: Padding(
                      //                     padding: EdgeInsets.only(
                      //                       top: 10,
                      //                     ),
                      //                     child: Text(
                      //                       "Isya",
                      //                       style: TextStyle(
                      //                         fontWeight: FontWeight.bold,
                      //                         fontSize: 15,
                      //                         color: Color(0xFF1d8b61),
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 SizedBox(
                      //                   width: 10,
                      //                 ),
                      //                 Expanded(
                      //                   flex: 5,
                      //                   child: Padding(
                      //                     padding:
                      //                         const EdgeInsets.only(top: 10),
                      //                     child: Text(
                      //                       v.dataimsyakya?.response?.isya ??
                      //                           "",
                      //                       textAlign: TextAlign.end,
                      //                       style: TextStyle(
                      //                           fontWeight: FontWeight.bold,
                      //                           fontSize: 23,
                      //                           color: Colors.black87),
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),

                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: CardA(
                              nama: "Imsak",
                              jam: v.dataimsyakya?.response?.imsak,
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: CardA(
                              nama: "Terbit",
                              jam: v.dataimsyakya?.response?.terbit,
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: CardA(
                              nama: "Subuh",
                              jam: v.dataimsyakya?.response?.subuh,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: CardA(
                              nama: "Dhuha",
                              jam: v.dataimsyakya?.response?.dhuha,
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: CardA(
                              nama: "Dzuhur",
                              jam: v.dataimsyakya?.response?.dzuhur,
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: CardA(
                              nama: "Ashar",
                              jam: v.dataimsyakya?.response?.ashar,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: CardA(
                              nama: "Maghrib",
                              jam: v.dataimsyakya?.response?.maghrib,
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: CardA(
                              nama: "Isya",
                              jam: v.dataimsyakya?.response?.isya,
                            ),
                          ),
                          Expanded(flex: 3, child: Container()),
                        ],
                      ),
                      // Container(
                      //   width: 300,
                      //   height: 200,
                      //   padding: EdgeInsets.symmetric(
                      //       horizontal: 10, vertical: 10),
                      //   decoration: BoxDecoration(color: Colors.white),
                      // ),
                    ],
                  )
                      // "tanggal": "Kamis, 23/03/2023",
                      // "imsak": "04:22",
                      // "subuh": "04:32",
                      // "terbit": "05:44",
                      // "dhuha": "06:11",
                      // "dzuhur": "11:53",
                      // "ashar": "15:05",
                      // "maghrib": "17:56",
                      // "isya": "19:04"

                      ),
                ));
    });
  }
}

class CardA extends StatefulWidget {
  String? nama;
  String? jam;
  // String? imsak;
  // String? subuh;
  // String? terbit;
  // String? dhuha;
  // String? dzuhur;
  // String? ashar;
  // String? maghrib;
  // String? isya;

  CardA({Key? key, this.nama, this.jam
      // this.imsak,
      // this.subuh,
      // this.terbit,
      // this.dhuha,
      // this.dzuhur,
      // this.ashar,
      // this.maghrib,
      // this.isya
      });

  @override
  State<CardA> createState() => _CardAState();
}

class _CardAState extends State<CardA> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xFFA67C00)),
              child: Icon(
                FlutterIslamicIcons.locationMosque,
                color: Colors.white,
                size: 30,
              )),
          SizedBox(
            height: 7,
          ),
          Text(
            widget.nama ?? "",
            style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            widget.jam ?? "",
            style: TextStyle(
                fontSize: 13,
                color: Colors.white70,
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
