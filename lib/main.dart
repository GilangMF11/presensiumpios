import 'dart:io';

import 'package:attedancekaryawanump/views/Auth/login.dart';
import 'package:attedancekaryawanump/views/homedashboard.dart';
import 'package:attedancekaryawanump/views/pengajian/rekappengajian.dart';
import 'package:attedancekaryawanump/views/provider/ramadhan/1444h/provideralquran.dart';
import 'package:attedancekaryawanump/views/provider/providerlogin.dart';
import 'package:attedancekaryawanump/views/provider/providerpengajian.dart';
import 'package:attedancekaryawanump/views/provider/providerpresensi.dart';
import 'package:attedancekaryawanump/views/provider/providerrekap.dart';
import 'package:attedancekaryawanump/views/provider/providerrekaplembur.dart';
import 'package:attedancekaryawanump/views/provider/providerrekaplogbook.dart';
import 'package:attedancekaryawanump/views/provider/providerrekappremit.dart';
import 'package:attedancekaryawanump/views/provider/ramadhan/1445h/providerRamadhan1445.dart';
import 'package:attedancekaryawanump/views/utils/sertifikatssl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'views/services/firebase_notification.dart';

void main() async {
  //Firbase Notification
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // await FirebaseApi().initNotification();
  initializeDateFormatting('id', null);
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Widget _defaultHome = Login();
  final prefs = await SharedPreferences.getInstance();
  bool? login = prefs.getBool('status');
  if (login == true) {
    _defaultHome = HomeDashboard();
  }
  // else if (login == "Mahasiswa") {
  //   _defaultHome = HomeDashboard();
  // }
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProviderLogin()),
        ChangeNotifierProvider(create: (_) => ProviderRekap()),
        ChangeNotifierProvider(create: (_) => ProviderRekapPermit()),
        ChangeNotifierProvider(create: (_) => ProviderRekapLembur()),
        ChangeNotifierProvider(create: (_) => ProviderRekapLogbook()),
        ChangeNotifierProvider(create: (_) => ProviderPresensi()),
        ChangeNotifierProvider(create: (_) => ProviderPengajian()),
        ChangeNotifierProvider(create: (_) => ProviderAlQuran()),
        ChangeNotifierProvider(create: (_) => ProviderRamadhan1445())
      ],
      child: Sizer(builder: (BuildContext context, Orientation orientation,
          DeviceType deviceType) {
        return MaterialApp(
          localizationsDelegates: [
            // GlobalMaterialLocalizations.delegate,
            // GlobalWidgetsLocalizations.delegate,
          ],
          locale: Locale("id"),
          debugShowCheckedModeBanner: false,
          // home: _defaultHome,
          home: _defaultHome,
        );
      })));
}
