import 'package:attedancekaryawanump/views/provider/providerlogin.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class Informasi extends StatefulWidget {
  Informasi();
  @override
  _InformasiState createState() => _InformasiState();
}

class _InformasiState extends State<Informasi> {
  late SharedPreferences sharedPreferences;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool? isloading = false;
  @override
  void initState() {
    super.initState();
    _Login();
  }

  _Login() async {
    final prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('usernameLogin');
    String? password = prefs.getString('passwordLogin');
    final _providerLogin =
        await Provider.of<ProviderLogin>(context, listen: false);
    await _providerLogin.providerLogin(username, password);
    setState(() {
      isloading = _providerLogin.loading;
    });
    print('pesan${_providerLogin.faillogin}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        centerTitle: false,
        title: Text('Informasi'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: const Color(0xFF0a4f8f),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          isloading == true
              ? Container(
                  height: 100,
                  width: 80,
                  child: Image(
                    image: AssetImage('assets/images/logo.png'),
                  ),
                )
              : Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    height: MediaQuery.of(context).size.height / 5,
                    width: MediaQuery.of(context).size.width / 2.5,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                ),
          SizedBox(
            height: 20,
          ),
          isloading == true
              ? Padding(
                  padding:
                      const EdgeInsets.only(bottom: 20.0, left: 25, right: 25),
                  child: Text(
                    "         Universitas Muhammadiyah Purwokerto (UMP) merupakan perguruan tinggi swasta terbesar di Jawa Tengah bagian barat, yang terakreditasi B. UMP secara aktif mengembangkan kerja sama Internasional dengan ratusan perguruan tinggi ternama dunia dalam bidang riset dan peningkatan kualitas sumber daya manusia (SDM). Selain itu, UMP saat ini juga memperkuat kerjasama dalam negeri.",
                    textAlign: TextAlign.justify,
                  ))
              : Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 100),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 2.3.h,
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 100),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 2.3.h,
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 100),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 2.3.h,
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
