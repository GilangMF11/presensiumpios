import 'package:attedancekaryawanump/views/model/modeldropdownpengajian.dart';
import 'package:attedancekaryawanump/views/model/modelrekappengajian.dart';
import 'package:attedancekaryawanump/views/provider/providerpengajian.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RekapPengajian extends StatefulWidget {
  RekapPengajian({Key? key}) : super(key: key);

  @override
  State<RekapPengajian> createState() => _RekapPengajianState();
}

class _RekapPengajianState extends State<RekapPengajian> {
  bool? statusdropdown = true;
  bool? loadinghit = false;

  getPegajian() async {
    final providerrekap =
        Provider.of<ProviderPengajian>(context, listen: false);
    await providerrekap.dropdownPengajian();
    setState(() {
      statusdropdown = providerrekap.statusdropdown;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getPegajian();
    });
    super.initState();
  }

  // getRekapPegajian(String bulan, String tahun) async {
  //   final providerrekap =
  //       Provider.of<ProviderPengajian>(context, listen: false);
  //   await providerrekap.rekapPengajian(bulan, tahun);

  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    List<DataRes>? lisData =
        Provider.of<ProviderPengajian>(context, listen: true)
            .listdropdownpengajian;
    List<DataPengajianA>? lisDatax =
        Provider.of<ProviderPengajian>(context, listen: true)
            .listrekappengajian;
    loadinghit =
        Provider.of<ProviderPengajian>(context, listen: true).loadinghit;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Rekap Pengajian'),
        backgroundColor: Color(0xFF0a4f8f),
      ),
      body: statusdropdown == false
          ? SingleChildScrollView(
              child:
                  // loadinghit == false
                  //     ? Center(
                  //         child:
                  Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      for (var i = 0; i < lisData!.length; i++)
                        CardMenu(
                          title: lisData[i].bulan,
                          bulan: lisData[i].bln,
                          tahun: lisData[i].th,
                          loadinghit: true,
                        ),
                    ],
                  ),
                ],
              ),
            )
          // : Container(
          //     width: MediaQuery.of(context).size.width,
          //     height: MediaQuery.of(context).size.height,
          //     color: Colors.transparent,
          //     child: Center(child: Text('Mohon Menunggu...')),
          //   ))
          : Center(
              child: CircularProgressIndicator.adaptive(
              backgroundColor: const Color(0xFF0a4f8f),
            )),
    ));
  }
}

class CardMenu extends StatefulWidget {
  String? title;
  String? bulan;
  String? tahun;
  bool? loadinghit;
  CardMenu({this.title, this.bulan, this.tahun, this.loadinghit});

  @override
  State<CardMenu> createState() => _CardMenuState();
}

class _CardMenuState extends State<CardMenu> {
  bool? statusloading = true;
  getRekapPegajian(String bulan, String tahun, bool? loadingA) async {
    final providerrekap =
        Provider.of<ProviderPengajian>(context, listen: false);
    await providerrekap.rekapPengajian(bulan, tahun, loadingA);
    statusloading = providerrekap.statusPengajian;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  // bool? statusrekaploading = false;

  @override
  Widget build(BuildContext context) {
    print(widget.title);
    print(widget.bulan);
    print(widget.tahun);

    return InkWell(
        onTap: () async {
          setState(() {
            statusloading = true;
            // statusrekaploading = true;
          });
          getRekapPegajian(
            widget.bulan ?? "",
            widget.tahun ?? "",
            widget.loadinghit,
          );
          showModalBottomSheet(
              context: context,
              builder: (context) {
                List<DataPengajianA>? lisDatax =
                    Provider.of<ProviderPengajian>(context, listen: true)
                        .listrekappengajian;
                statusloading =
                    Provider.of<ProviderPengajian>(context, listen: true)
                        .loadinghit;
                return statusloading == false
                    ? Container(
                        color: Colors.white,
                        child: lisDatax!.length > 0
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 20),
                                    child: Text(
                                      ':: List Presensi ::',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 6, horizontal: 40),
                                    child: Divider(),
                                  ),
                                  for (var i = 0; i < lisDatax.length; i++)
                                    cardlist(
                                      lisDatax[i].temaPengajian ?? "",
                                      lisDatax[i].hikmah ?? "",
                                      lisDatax[i].waktuPresensi ?? "",
                                    )
                                ],
                              )
                            : Center(
                                child: Container(
                                    child: Text(
                                        'Tidak ada presensi di bulan ini')),
                              ),
                      )
                    : Center(
                        child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        color: Colors.transparent,
                        child: Center(child: Text('Mohon Menunggu...')),
                      ));
              });
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          height: 50,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
          child: Card(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(widget.title ?? ""),
                  Icon(Icons.keyboard_arrow_down_sharp)
                ],
              ),
            ),
          )),
        ));
  }

  cardlist(String title, String hikmah, String tanggal) {
    return Container(
      margin: EdgeInsets.only(bottom: 7),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Card(
          elevation: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Icon(
                  Icons.mosque,
                  color: Colors.green,
                ),
                title: Text(title),
                onTap: () {
                  // Navigator.pop(context);
                },
              ),
              Container(
                margin:
                    EdgeInsets.only(top: 10, bottom: 50, left: 10, right: 10),
                child: Text(
                  hikmah,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // Container(
              //   margin:
              //       EdgeInsets.only(top: 0, bottom: 25, left: 10, right: 10),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       Expanded(child: Container()),
              //       Expanded(
              //           child: Align(
              //               alignment: Alignment.centerRight,
              //               child: Text(tanggal))),
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
