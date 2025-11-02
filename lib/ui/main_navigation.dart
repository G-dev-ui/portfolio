import 'package:flutter/material.dart';
import 'pages/characters_page.dart';
import 'pages/favorites_page.dart';


class MainNavigation extends StatefulWidget {
  const MainNavigation({Key? key}) : super(key: key);

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final _pages = const [
    CharactersPage(),
    FavoritesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/home.png',
              width: 24,
              height: 24,
            ),
            label: 'Персонажи',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/like.png',
              width: 24,
              height: 24,
            ),
            label: 'Избранное',
          ),
        ],
      ),
    );
  }
}
