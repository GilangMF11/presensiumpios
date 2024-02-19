import 'dart:async';

import 'package:attedancekaryawanump/views/about.dart';
import 'package:attedancekaryawanump/views/dashboardkaryawan.dart';
import 'package:attedancekaryawanump/views/profile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeDashboard extends StatefulWidget {
  HomeDashboard({Key? key}) : super(key: key);

  @override
  _HomeDashboardState createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  @override
  void initState() {
    super.initState();
  }

  int _selectedIndex = 0;

  final _pageOptions = [
    DashbardKaryawan(),
    Informasi(),
    Profile(),

    // ViewPrfileMahasiswa(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color(0xFF0a4f8f),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Menu',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.album_outlined),
              label: 'About',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped),
    );
  }
}
