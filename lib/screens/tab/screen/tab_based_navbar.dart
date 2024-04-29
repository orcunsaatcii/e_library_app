import 'package:e_ibrary_app/screens/home/screen/home_screen.dart';
import 'package:e_ibrary_app/screens/library/screen/library_screen.dart';
import 'package:flutter/material.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    const HomeScreen(),
    const LibraryScreen(),
  ];

  void switchSceeen(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        iconSize: 30,
        elevation: 40,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_filled,
              color: Theme.of(context).colorScheme.primary,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.library_books,
              color: Theme.of(context).colorScheme.primary,
            ),
            label: 'Library',
          ),
        ],
        onTap: switchSceeen,
      ),
    );
  }
}
