import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helloworld_app/screens/aboutUs.dart';
import 'package:helloworld_app/screens/home.dart';
import 'package:helloworld_app/screens/submit.dart';


class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {

  int currentIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: IndexedStack(
            index: currentIndex,
            children: [
              Home(),
              Submit(),
              AboutUs()
            ],
          )
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.blue,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            title: Text('Submit'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            title: Text('About Us',),
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

