import 'package:attedancekaryawanump/views/provider/ramadhan/1445h/providerRamadhan1445.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RekapPresensiRamadhan1445 extends StatefulWidget {
  const RekapPresensiRamadhan1445({Key? key}) : super(key: key);

  @override
  State<RekapPresensiRamadhan1445> createState() => _RekapPresensiRamadhan1445State();
}

class _RekapPresensiRamadhan1445State extends State<RekapPresensiRamadhan1445> {
  bool? loading = true;

  getPegajian() async {
    final providerrekap = Provider.of<ProviderRamadhan1445>(context, listen: false);
    await providerrekap.getRekapPresensiRamadhan();
    setState(() {
      loading = providerrekap.rekaploadingramadhan;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getPegajian();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderRamadhan1445>(builder: (context, v, Child) {
      return SafeArea(
          child: Scaffold(
        appBar: AppBar(
          title: const Text('Rekap Pengajian'),
          backgroundColor: const Color(0xFF1d8b61),
        ),
        body: loading == false
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
                        for (var i = 0;
                            i < v.rekappresensiramadhan!.response!.length;
                            i++)
                          CardMenu(
                            title:
                                v.rekappresensiramadhan!.response![i].kegiatan,
                            hikmah:
                                v.rekappresensiramadhan!.response![i].hikmah,
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
            : const Center(
                child: CircularProgressIndicator.adaptive(
                backgroundColor: Color(0xFF0a4f8f),
              )),
      ));
    });
  }
}


// ignore: must_be_immutable
class CardMenu extends StatefulWidget {
  String? title;
  String? hikmah;
  CardMenu({Key? key, this.title, this.hikmah}) : super(key: key);

  @override
  State<CardMenu> createState() => _CardMenuState();
}

class _CardMenuState extends State<CardMenu> {
  // bool? statusloading = true;
  // getRekapPegajian(String bulan, String tahun, bool? loadingA) async {
  //   final providerrekap =
  //       Provider.of<ProviderPengajian>(context, listen: false);
  //   await providerrekap.rekapPengajian(bulan, tahun, loadingA);
  //   statusloading = providerrekap.statusPengajian;
  //   setState(() {});
  // }

  // @override
  // void initState() {
  //   super.initState();
  // }

  // bool? statusrekaploading = false;

  @override
  Widget build(BuildContext context) {
    print(widget.title);
    print(widget.hikmah);

    return InkWell(
        onTap: () async {
          // setState(() {
          //   statusloading = true;
          //   // statusrekaploading = true;
          // });
          // getRekapPegajian(
          //   widget.bulan ?? "",
          //   widget.tahun ?? "",
          //   widget.loadinghit,
          // );
          showModalBottomSheet(
              context: context,
              builder: (context) {
                // List<DataPengajianA>? lisDatax =
                //     Provider.of<ProviderPengajian>(context, listen: true)
                //         .listrekappengajian;
                // statusloading =
                //     Provider.of<ProviderPengajian>(context, listen: true)
                //         .loadinghit;
                return Container(
                    color: Colors.white,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: const Text(
                            ':: List Presensi ::',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w700),
                          ),
                        ),
                        Container(
                          margin:
                              const EdgeInsets.symmetric(vertical: 6, horizontal: 40),
                          child: const Divider(),
                        ),
                        cardlist(widget.title ?? "", widget.hikmah ?? "")
                      ],
                    ));
              });
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          height: 50,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
          child: Card(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 9,
                    child: Text(
                      widget.title ?? "",
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Expanded(child: Icon(Icons.keyboard_arrow_down_sharp))
                ],
              ),
            ),
          )),
        ));
  }

  cardlist(String title, String hikmah) {
    return Container(
      margin: const EdgeInsets.only(bottom: 7),
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
                leading: const Icon(
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
                    const EdgeInsets.only(top: 10, bottom: 50, left: 10, right: 10),
                child: Text(
                  hikmah,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
