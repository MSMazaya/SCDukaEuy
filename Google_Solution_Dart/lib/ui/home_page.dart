import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:foody/ui/doctor_page.dart';
import 'package:foody/ui/pasian_page.dart';
import 'package:foody/widgets/common_widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _screens = [
    PasienState(),
    DoctorState(),
  ];

  int _activeScreenIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_activeScreenIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services_rounded),
            title: Text('Pasien'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            title: Text('Doctor'),
          ),
        ],
        currentIndex: _activeScreenIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: (index) {
          setState(() {
            _activeScreenIndex = index;
          });
        },
      ),
    );
  }
}