import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';

import '1444h/amalia_pages.dart';
import '1445h/v_ramadhan1445.dart';

class RamadhanPage extends StatefulWidget {
  const RamadhanPage({Key? key}) : super (key: key);

  @override
  State<RamadhanPage> createState() => _RamadhanPageState();
}

class _RamadhanPageState extends State<RamadhanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1d8b61),
        title: const Text('Ramadhan'),
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              children: [
                
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const Ramadhan1455()));
                  },
                  child: Container(
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.width,
                      padding:
                          const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      margin:
                          const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
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
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Center(
                                    child: Text(
                                      "Ramadhan 1445 Hijriyah",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                        color: Color(0xFF1d8b61),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const AmaliaPages()));
                  },
                  child: Container(
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.width,
                      padding:
                          const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      margin:
                          const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      // color: Colors.red,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: const Color.fromARGB(255, 79, 84, 82),
                          )),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              height: double.infinity,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  color: Colors.grey,
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
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Center(
                                    child: Text(
                                      "Ramadhan 1444 Hijriyah",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 79, 84, 82),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            ),
          )),
    );
  }
}