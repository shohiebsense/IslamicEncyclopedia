
import 'package:ensiklopedia_islam/style/color.dart';
import 'package:flutter/material.dart';

class BottomNavBarView extends StatelessWidget {
  int _selectedIndex = 0;
  Function onNanBarItemTapped;


  BottomNavBarView(this.onNanBarItemTapped);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: COLOR_DEFAULT,
      unselectedItemColor: Colors.white,
      showUnselectedLabels: true,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Histori',
          backgroundColor: Color(0xff1f1f1f),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          label: 'Nabi',
          backgroundColor: Color(0xff1f1f1f),
        ),
        BottomNavigationBarItem(

          icon: Icon(Icons.school),
          label: 'Sahabat',

          backgroundColor: Color(0xff1f1f1f),
        ),
        BottomNavigationBarItem(

          icon: Icon(Icons.school),
          label: 'Ulama',

          backgroundColor: Color(0xff1f1f1f),
        ),

      ],
      selectedItemColor: Colors.amber,
      currentIndex: _selectedIndex,
      onTap: onNanBarItemTapped(),
    );
  }
}
