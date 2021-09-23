import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_latihan/pages/menu/account_page.dart';
import 'package:project_latihan/pages/menu/home_page.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _children = [const HomePage(), AccountPage()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _children[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: _selectedIndex == 0
                    ? SvgPicture.asset(
                        'assets/icons/home_black_24dp_filled.svg')
                    : SvgPicture.asset(
                        'assets/icons/home_black_24dp_outline.svg'),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: _selectedIndex == 1
                    ? SvgPicture.asset(
                        'assets/icons/account_circle_black_24dp_filled.svg')
                    : SvgPicture.asset(
                        'assets/icons/account_circle_black_24dp_outline.svg'),
                label: 'Home'),
          ],
          currentIndex: _selectedIndex,
          // selectedItemColor: mTitleColor,
          // unselectedItemColor: mSubtitleColor,
          onTap: _onItemTapped,
          // backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12,
          unselectedFontSize: 10,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          showUnselectedLabels: true,
          // elevation: 0
        ));
  }
}
