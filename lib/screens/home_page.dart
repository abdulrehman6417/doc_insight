import 'package:doc_insight/screens/history_screen.dart';
import 'package:doc_insight/screens/main_options.dart';
import 'package:doc_insight/screens/profile_screen.dart';
import 'package:doc_insight/screens/settings_screen.dart';
import 'package:doc_insight/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final PersistentTabController _navBarController =
      PersistentTabController(initialIndex: 0);

  List<Widget> _screensList() {
    return [
      const MainOptions(),
      const HistoryPage(),
      const SettingsPage(),
      const ProfilePage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const ImageIcon(
          AssetImage('assets/images/home.png'),
          size: 30.0,
        ),
        activeColorPrimary: primaryBlue,
        inactiveColorPrimary: Colors.black.withOpacity(0.7),
      ),
      PersistentBottomNavBarItem(
        icon: const ImageIcon(
          AssetImage('assets/images/history2.png'),
          size: 30.0,
        ),
        activeColorPrimary: primaryBlue,
        inactiveColorPrimary: Colors.black.withOpacity(0.7),
      ),
      PersistentBottomNavBarItem(
        icon: const ImageIcon(
          AssetImage('assets/images/setting2.png'),
          size: 30.0,
        ),
        activeColorPrimary: primaryBlue,
        inactiveColorPrimary: Colors.black.withOpacity(0.7),
      ),
      PersistentBottomNavBarItem(
        icon: const ImageIcon(
          AssetImage('assets/images/profile.png'),
          size: 30.0,
        ),
        activeColorPrimary: primaryBlue,
        inactiveColorPrimary: Colors.black.withOpacity(0.7),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(context,
        screens: _screensList(),
        items: _navBarItems(),
        controller: _navBarController,
        navBarStyle: NavBarStyle.style6,
        navBarHeight: 70.0,
        backgroundColor: secondaryWhite,
        popAllScreensOnTapOfSelectedTab: true,
        decoration: NavBarDecoration(
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black.withOpacity(0.10),
          //     offset: const Offset(0, -2),
          //     blurRadius: 4.0,
          //   ),
          // ],
          border: Border(
            top: BorderSide(
              color: color4LightGray,
              width: 2.0,
            ),
            left: BorderSide(color: color4LightGray),
            right: BorderSide(color: color4LightGray),
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ));
  }
}
