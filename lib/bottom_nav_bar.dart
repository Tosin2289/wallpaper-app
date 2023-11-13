import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wallpaper_app/pages/allScreen.dart';
import 'package:wallpaper_app/pages/homeScreen.dart';
import 'package:wallpaper_app/pages/searchScreen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List pages = const [HomeScreen(), SearchScreen(), AllScreen()];
  int currentindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: pages[currentindex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: currentindex,
        onTap: (value) {
          setState(() {
            currentindex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Iconsax.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Iconsax.search_normal), label: ''),
          BottomNavigationBarItem(icon: Icon(Iconsax.menu_board), label: ''),
        ],
      ),
    );
  }
}
