import 'dart:ui';

import 'package:attedancekaryawanump/views/Auth/login.dart';
import 'package:attedancekaryawanump/views/log/log.dart';
import 'package:attedancekaryawanump/views/model/modellogin.dart';
import 'package:attedancekaryawanump/views/provider/providerlogin.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class Profile extends StatefulWidget {
  Profile();

  @override
  ProfileRouteState createState() => ProfileRouteState();
}

class ProfileRouteState extends State<Profile> {
  late SharedPreferences sharedPreferences;
  bool? isloading = false;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _Login();
    });
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
    String? nama = Provider.of<ProviderLogin>(context, listen: false).nama;
    ModelLogin? data = Provider.of<ProviderLogin>(context, listen: false).data;
    return Scaffold(
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          backgroundColor: const Color(0xFF0a4f8f),
          pinned: true,
          floating: false,
          snap: false,
          expandedHeight: MediaQuery.of(context).size.height / 3,
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.pin,
            centerTitle: true,
            // title: Text('Biodata'),
            background: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isloading == true
                    ? Container(
                        height: MediaQuery.of(context).size.height / 4,
                        width: MediaQuery.of(context).size.width / 2.5,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/profile.png'),
                            fit: BoxFit.contain,
                          ),
                          shape: BoxShape.circle,
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
                Column(
                  children: [
                    isloading == true
                        ? Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 100),
                            child: Text(nama ?? "",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          )
                        : Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 100),
                            child: SizedBox(
                              width: 30.w,
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
                    isloading == true
                        ? Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 120),
                            child: Text(data?.data?.username ?? "",
                                style: TextStyle(
                                    fontSize: 12.sp, color: Colors.white)),
                          )
                        : Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 100),
                            child: SizedBox(
                              width: 30.w,
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
                )
              ],
            ),
          ),
        ),
        SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            return Column(
              children: [
                Column(
                  children: [
                    isloading == true
                        ? Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 10, right: 10),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 13,
                              child: ListTile(
                                leading: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 10,
                                  width: MediaQuery.of(context).size.width / 10,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF0a4f8f),
                                    shape: BoxShape.circle,
                                  ),
                                  child:
                                      Icon(Icons.person, color: Colors.white),
                                ),
                                title: Text(
                                  'NAMA : ',
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              25,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(data?.data?.nama ?? "",
                                    style: TextStyle(
                                        fontSize: 12.sp, color: Colors.black)),
                              ),
                            ),
                          )
                        : Padding(
                            padding:
                                EdgeInsets.only(top: 10, left: 10, right: 10),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 12,
                              child: ListTile(
                                leading: Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 9,
                                    width:
                                        MediaQuery.of(context).size.width / 9,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                title: Padding(
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height /
                                          100),
                                  child: SizedBox(
                                    width: 30.w,
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
                                subtitle: Padding(
                                  padding: EdgeInsets.only(top: 8),
                                  child: SizedBox(
                                    width: 30.w,
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
                                onTap: () {},
                                enabled: false,
                              ),
                            ),
                          ),
                    Divider(),
                    isloading == true
                        ? Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 13,
                              child: ListTile(
                                leading: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 10,
                                  width: MediaQuery.of(context).size.width / 10,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF0a4f8f),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(Icons.gps_not_fixed_outlined,
                                      color: Colors.white),
                                ),
                                title: Text(
                                  'NIK : ',
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              25,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(data?.data?.username ?? "",
                                    style: TextStyle(
                                        fontSize: 12.sp, color: Colors.black)),
                              ),
                            ),
                          )
                        : Padding(
                            padding:
                                EdgeInsets.only(top: 10, left: 10, right: 10),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 12,
                              child: ListTile(
                                leading: Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 9,
                                    width:
                                        MediaQuery.of(context).size.width / 9,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                title: Padding(
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height /
                                          100),
                                  child: SizedBox(
                                    width: 30.w,
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
                                subtitle: Padding(
                                  padding: EdgeInsets.only(top: 8),
                                  child: SizedBox(
                                    width: 30.w,
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
                                onTap: () {},
                                enabled: false,
                              ),
                            ),
                          ),
                    Divider(),
                    isloading == true
                        ? Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 13,
                              child: ListTile(
                                leading: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 10,
                                  width: MediaQuery.of(context).size.width / 10,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF0a4f8f),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(Icons.business_center_outlined,
                                      color: Colors.white),
                                ),
                                title: Text(
                                  'Unit : ',
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              25,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text("-",
                                    style: TextStyle(
                                        fontSize: 12.sp, color: Colors.black)),
                              ),
                            ),
                          )
                        : Padding(
                            padding:
                                EdgeInsets.only(top: 10, left: 10, right: 10),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 12,
                              child: ListTile(
                                leading: Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 9,
                                    width:
                                        MediaQuery.of(context).size.width / 9,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                title: Padding(
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height /
                                          100),
                                  child: SizedBox(
                                    width: 30.w,
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
                                subtitle: Padding(
                                  padding: EdgeInsets.only(top: 8),
                                  child: SizedBox(
                                    width: 30.w,
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
                                onTap: () {},
                                enabled: false,
                              ),
                            ),
                          ),
                    Divider(),
                    isloading == true
                        ? Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 13,
                              child: ListTile(
                                leading: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 10,
                                  width: MediaQuery.of(context).size.width / 10,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF0a4f8f),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(Icons.info_outline_rounded,
                                      color: Colors.white),
                                ),
                                title: Text(
                                  'Contact : ',
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              25,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text("-",
                                    style: TextStyle(
                                        fontSize: 12.sp, color: Colors.black)),
                              ),
                            ),
                          )
                        : Padding(
                            padding:
                                EdgeInsets.only(top: 10, left: 10, right: 10),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 12,
                              child: ListTile(
                                leading: Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 9,
                                    width:
                                        MediaQuery.of(context).size.width / 9,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                title: Padding(
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height /
                                          100),
                                  child: SizedBox(
                                    width: 30.w,
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
                                subtitle: Padding(
                                  padding: EdgeInsets.only(top: 8),
                                  child: SizedBox(
                                    width: 30.w,
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
                                onTap: () {},
                                enabled: false,
                              ),
                            ),
                          ),
                  ],
                ),
                Divider(),
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    isloading = false;
                    setState(() {
                      prefs.clear();
                    });
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                        (Route<dynamic> route) => false);
                  },
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 22.w, vertical: 1.5.h),
                    padding: EdgeInsets.only(left: 6.w, right: 6.w),
                    child: Text(
                      'Logout',
                      style: TextStyle(color: Colors.white, fontSize: 12.sp),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0a4f8f),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                )
              ],
            );
          }, childCount: 1),
        ),
      ]),
    );
  }
}
