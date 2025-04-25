import 'package:casaflutterapp/src/explore/view/screens/explore_screen.dart';
import 'package:casaflutterapp/src/home/view/screens/home_screen.dart';
import 'package:casaflutterapp/src/profile/view/screens/profile_screen.dart';
import 'package:casaflutterapp/utils/color_constant.dart';
import 'package:casaflutterapp/utils/string_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../cart/view/screens/cart_screen.dart';
import '../../../onboarding/view/screens/onboarding_screen.dart';
import '../../../wishlist/view/screens/wishlist_screen.dart';

class NavPage extends StatefulWidget {
  const NavPage({super.key, this.isFirstLaunch = false});

  final bool isFirstLaunch;

  @override
  NavPageState createState() => NavPageState();
}

class NavPageState extends State<NavPage> {
  bool _isFirstLaunch = true; // Variable to track first launch
  int _selectedIndex = 0; // Track the selected index of the BottomNavigationBar

  // IMP : Flutter will create the widgets list eagerly resulting in controller
  // initialization without navigation when bottom navbar is created,
  // to avoid use a conditional widget building ( switch case ) and getters

  Widget _getScreen(int index) {
    switch (index) {
      case 0:
        return HomeScreen();
      case 1:
        return ExploreScreen();
      case 2:
        return CartScreen();
      case 3:
        return WishlistScreen();
      case 4:
        return ProfileScreen();
      default:
        return Container();
    }
  }

  @override
  void initState() {
    super.initState();
    _isFirstLaunch = widget.isFirstLaunch;
    // inProductionSnackbar();
  }

  // Function to handle bottom navigation item selection
  void _onItemTapped(int index) {
    if (index == 3) {
      HapticFeedback.heavyImpact();
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundColor.white,
      body: Stack(
        children: [
          _getScreen(_selectedIndex), // Display the selected page
          TutorialScreen(
            isFirstTime: _isFirstLaunch,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        backgroundColor: BottomNavigationColor.white,
        elevation: 0,
        fixedColor: BottomNavigationColor.black,
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        // Handle item tap
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset(
              IconConstants.home,
              height: 28.0,
              width: 28.0,
            ),
            activeIcon: Image.asset(
              IconConstants.homeSelected,
              height: 28.0,
              width: 28.0,
            ),
            label: '',
            backgroundColor: BottomNavigationColor.white,
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              IconConstants.search,
              height: 28.0,
              width: 28.0,
            ),
            activeIcon: Image.asset(
              IconConstants.searchSelected,
              height: 28.0,
              width: 28.0,
            ),
            label: '',
            backgroundColor: BottomNavigationColor.white,
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              IconConstants.cart,
              height: 28.0,
              width: 28.0,
            ),
            activeIcon: Image.asset(
              IconConstants.cartSelected,
              height: 28.0,
              width: 28.0,
            ),
            label: '',
            backgroundColor: BottomNavigationColor.white,
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              IconConstants.heart,
              height: 28.0,
              width: 28.0,
            ),
            activeIcon: Image.asset(
              IconConstants.heartSelected,
              height: 28.0,
              width: 28.0,
            ),
            label: '',
            backgroundColor: BottomNavigationColor.white,
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              IconConstants.profile,
              height: 28.0,
              width: 28.0,
            ),
            activeIcon: Image.asset(
              IconConstants.profileSelected,
              height: 28.0,
              width: 28.0,
            ),
            label: '',
            backgroundColor: BottomNavigationColor.white,
          )
        ],
      ),
    );
  }
}
