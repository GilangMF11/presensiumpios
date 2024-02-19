import 'dart:convert';

import 'package:attedancekaryawanump/views/homedashboard.dart';
import 'package:attedancekaryawanump/views/provider/providerlogin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  double get screenheight => MediaQuery.of(context).size.height;
  double get screenwidght => MediaQuery.of(context).size.width;
  bool _isObscure = true;
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  late SharedPreferences sharedPreferences;
  bool _isloading = false;

  _Login(String username, String password) async {
    if (username == '') {
      setState(() {
        _isloading = false;
      });
      Fluttertoast.showToast(
          msg: 'Username Tidak Boleh Kosong',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (password == '') {
      setState(() {
        _isloading = false;
      });
      Fluttertoast.showToast(
          msg: 'Password Tidak Boleh Kosong',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      final _providerLogin = Provider.of<ProviderLogin>(context, listen: false);
      await _providerLogin.providerLogin(username, password);
      // print('pesan${_providerLogin.faillogin}');
      if (_providerLogin.faillogin == false) {
        setState(() {
          _isloading = false;
        });
        Fluttertoast.showToast(
            msg: 'Username dan Password tidak sesuai',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (_providerLogin.faillogin == true) {
        setState(() {
          _isloading = true;
        });
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomeDashboard()),
            (route) => false);
      } else {
        setState(() {
          setState(() {
            _isloading = false;
          });
        });
        Fluttertoast.showToast(
            msg: 'Username dan Password tidak sesuai',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          child: Container(
              padding: EdgeInsets.only(bottom: 4.h),
              // color: Color(0xFFf3f2f2),
              child: Stack(
                children: [
                  CustomPaint(
                    painter: ShapesPainter(),
                    child: Container(height: screenheight / 1.3),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: screenwidght / 5.5),
                        child: Center(
                          child: Image.asset(
                            'assets/images/logo.png',
                            width: 25.w,
                            height: 25.w,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 1.h, top: 1.h),
                        child: Center(
                            child: Text(
                          'ATTANDANCE',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600),
                        )),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: screenheight / 30),
                        child: Center(
                            child: Text(
                          'Fill The Bellow Information to Log In',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400),
                        )),
                      ),
                      Padding(
                        padding: EdgeInsets.only(),
                        child: Center(
                          child: Container(
                            width: screenwidght / 1.27,
                            height: screenheight / 2,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(screenwidght / 20),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.4),
                                  spreadRadius: 0.5,
                                  blurRadius: 2,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                )
                              ],
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: screenheight / 30,
                                  ),
                                  child: Center(
                                      child: Text(
                                    'Login Karyawan',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600),
                                  )),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 9, bottom: screenwidght / 15),
                                  child: Center(
                                      child: Text(
                                    'dengan akun SIMPEG',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10.sp,
                                    ),
                                  )),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: screenwidght / 15,
                                      right: screenwidght / 15,
                                      bottom: screenwidght / 18),
                                  child: Center(
                                    child: TextField(
                                      style: TextStyle(fontSize: 12.sp),
                                      controller: _username,
                                      // inputFormatters: [
                                      //   FilteringTextInputFormatter.allow(
                                      //       RegExp("[A-Za-z0-9#+-.]")),
                                      // ],
                                      decoration: InputDecoration(
                                        hintStyle: TextStyle(fontSize: 12.sp),
                                        label: Text(
                                          'Username',
                                          style: TextStyle(fontSize: 12.sp),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: screenwidght / 15,
                                      right: screenwidght / 15),
                                  child: Center(
                                    child: TextField(
                                      controller: _password,
                                      obscureText: _isObscure,
                                      style: TextStyle(fontSize: 12.sp),
                                      decoration: InputDecoration(
                                          hintStyle: TextStyle(fontSize: 12.sp),
                                          label: Text(
                                            'Password',
                                            style: TextStyle(fontSize: 12.sp),
                                          ),
                                          suffixIcon: IconButton(
                                              icon: Icon(_isObscure
                                                  ? Icons.visibility_off
                                                  : Icons.visibility),
                                              onPressed: () {
                                                setState(() {
                                                  _isObscure = !_isObscure;
                                                });
                                              })),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: screenwidght / 13,
                                ),
                                _isloading == false
                                    ? ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            _isloading = true;
                                            _Login(
                                                _username.text, _password.text);
                                          });
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 22.w,
                                              vertical: 1.5.h),
                                          padding: EdgeInsets.only(
                                              left: 1.w, right: 1.w),
                                          child: Text(
                                            'Login',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12.sp),
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xFF0a4f8f),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      )
                                    : ElevatedButton(
                                        onPressed: () {
                                          _isloading = false;
                                          setState(() {});
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 22.w,
                                              vertical: 1.5.h),
                                          padding: EdgeInsets.only(
                                              left: 1.w, right: 1.w),
                                          child: Container(
                                            height: 2.5.h,
                                            width: 6.5.w,
                                            child:
                                                const CircularProgressIndicator(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.grey,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      )
                                // _isloading == true
                                //     ?

                                // Container(
                                //     alignment: Alignment.centerRight,
                                //     margin: EdgeInsets.symmetric(
                                //         horizontal: screenwidght / 13,
                                //         vertical: screenwidght / 40),
                                //     child: RaisedButton(
                                //       onPressed: () {
                                //         setState(() {
                                //           _isloading = false;
                                //         });
                                //       },
                                //       shape: RoundedRectangleBorder(
                                //           borderRadius:
                                //               BorderRadius.circular(
                                //                   screenwidght / 20)),
                                //       textColor: Colors.white,
                                //       padding: const EdgeInsets.all(0),
                                //       child: Container(
                                //           alignment: Alignment.center,
                                //           height: screenwidght / 10,
                                //           width: screenheight * 0.5,
                                //           decoration: BoxDecoration(
                                //               borderRadius:
                                //                   BorderRadius.circular(
                                //                       screenwidght / 10),
                                //               color: Colors.grey
                                //               // gradient:
                                //               //     new LinearGradient(colors: [
                                //               //   Color.fromARGB(
                                //               //       255, 69, 30, 180),
                                //               //   Color.fromARGB(
                                //               //       255, 69, 56, 212),
                                //               // ])
                                //               ),
                                //           padding: const EdgeInsets.all(0),
                                //           child: Row(
                                //             mainAxisAlignment:
                                //                 MainAxisAlignment.center,
                                //             crossAxisAlignment:
                                //                 CrossAxisAlignment.center,
                                //             children: [
                                //               Text(
                                //                 "Waiting..",
                                //                 textAlign: TextAlign.center,
                                //                 style: TextStyle(
                                //                     fontWeight:
                                //                         FontWeight.w300,
                                //                     fontSize:
                                //                         screenwidght / 28),
                                //               ),
                                //               SizedBox(
                                //                 width: screenwidght / 50,
                                //               ),
                                //               Container(
                                //                   height: screenwidght / 20,
                                //                   width: screenwidght / 20,
                                //                   child:
                                //                       CircularProgressIndicator(
                                //                     color: Colors.white,
                                //                   ))
                                //             ],
                                //           )),
                                //     ),
                                //   )
                                // : Container(
                                //     alignment: Alignment.centerRight,
                                //     margin: EdgeInsets.symmetric(
                                //         horizontal: screenwidght / 13,
                                //         vertical: screenwidght / 40),
                                //     child: RaisedButton(
                                //       onPressed: () {
                                //         setState(() {
                                //           _isloading = true;
                                //           _Login(_username.text,
                                //               _password.text);
                                //           // _isloading = true;
                                //           // Navigator.pushAndRemoveUntil(
                                //           //   context,
                                //           //   MaterialPageRoute(
                                //           //       builder: (context) =>
                                //           //           HomeDashboard()),
                                //           //   (Route<dynamic> route) => false,
                                //           // );
                                //         });
                                //       },
                                //       shape: RoundedRectangleBorder(
                                //           borderRadius:
                                //               BorderRadius.circular(
                                //                   screenwidght / 20)),
                                //       textColor: Colors.white,
                                //       padding: const EdgeInsets.all(0),
                                //       child: Container(
                                //         alignment: Alignment.center,
                                //         height: screenwidght / 10,
                                //         width: screenheight * 0.5,
                                //         decoration: BoxDecoration(
                                //             borderRadius:
                                //                 BorderRadius.circular(
                                //                     screenwidght / 10),
                                //             gradient: const LinearGradient(
                                //                 colors: [
                                //                   Color.fromARGB(
                                //                       255, 10, 79, 143),
                                //                   Color.fromARGB(
                                //                       255, 10, 100, 160),
                                //                 ]
                                //                 // gradient:
                                //                 //     const LinearGradient(colors: [
                                //                 //   Color.fromARGB(
                                //                 //       255, 69, 30, 180),
                                //                 //   Color.fromARGB(
                                //                 //       255, 69, 56, 212),
                                //                 // ]
                                //                 )),
                                //         padding: const EdgeInsets.all(0),
                                //         child: Text(
                                //           "LOGIN",
                                //           textAlign: TextAlign.center,
                                //           style: TextStyle(
                                //               fontWeight: FontWeight.bold,
                                //               fontSize: 12.sp),
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: screenwidght / 15,
                              left: screenwidght / 15,
                              right: screenwidght / 15),
                          child: Text(
                            'Universitas Muhammadiyah',
                            style: TextStyle(fontSize: 12.sp),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: screenwidght / 15,
                              right: screenwidght / 15),
                          child: Text(
                            'Purwokerto',
                            style: TextStyle(fontSize: 12.sp),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }
}

const double _kCurveHeight = 35;

class ShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Path();
    p.lineTo(0, size.height - _kCurveHeight);
    p.relativeQuadraticBezierTo(
        size.width / 2, 2 * _kCurveHeight, size.width, 0);
    p.lineTo(size.width, 0);
    p.close();

    canvas.drawPath(
      p,
      Paint()..color = Color(0xFF0a4f8f),
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
