import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helloworld_app/constants.dart';
import 'package:helloworld_app/screens/aboutUs.dart';
import 'package:helloworld_app/screens/home.dart';
import 'package:helloworld_app/screens/submit.dart';

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kConstBlueColor,
      body: SafeArea(
          child: IndexedStack(
        index: currentIndex,
        children: [Home(), Submit(), AboutUs()],
      )),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kConstBlueColor,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.pin_drop),
            title: Text('Explore'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            title: Text('Create'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            title: Text(
              'About Us',
            ),
          ),
        ],
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
