
import 'package:flutter/material.dart';

class BottomNavBarView extends StatelessWidget {
  int _selectedIndex = 0;
  Function onNanBarItemTapped;


  BottomNavBarView(this.onNanBarItemTapped);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Histori',
          backgroundColor: Colors.red,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          label: 'Nabi',
          backgroundColor: Colors.green,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'Ulama',
          backgroundColor: Colors.purple,
        ),

      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: onNanBarItemTapped(),
    );
  }
}
