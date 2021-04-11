import 'package:flutter/material.dart';

import './favorite_screen.dart';
import './categories_screen.dart';
import '../widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Widget> _pages = [
    CategoriesScreen(),
    FavoriteScreen(),
  ];

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    // 'index' is the index of the tab selected
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Tab bar at the bottom of the screen
    return Scaffold(
      appBar: AppBar(
        title: Text('DeliMeals'),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex, // Selected tab is highlighted
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColorLight,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );

    // Tab bar at the top, underneath the app bar
    // DefaultTabController(
    //   length: 2, // total number of tabs
    //   child: Scaffold(
    //     appBar: AppBar(
    //       title: Text('DeliMeals'),
    //       bottom: TabBar(
    //         tabs: [
    //           Tab(
    //             icon: Icon(Icons.category),
    //             text: 'Categories',
    //           ),
    //           Tab(
    //             icon: Icon(Icons.star),
    //             text: 'Favorites',
    //           ),
    //         ],
    //       ),
    //     ),
    //     body: TabBarView(
    //       children: [
    //         CategoriesScreen(), // equivalent to tab 0
    //         FavoriteScreen(), // equivalent to tab 1
    //       ],
    //     ),
    //   ),
    // );
  }
}
