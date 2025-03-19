import 'package:casaflutter/src/explore/view/screens/explore_screen.dart';
import 'package:casaflutter/src/home/view/screens/home_screen.dart';
import 'package:casaflutter/src/profile/view/screens/profile_screen.dart';
import 'package:casaflutter/utils/color_constant.dart';
import 'package:flutter/material.dart';

import '../../../cart/view/screens/cart_screen.dart';
import '../../../onboarding/view/screens/onboarding_screen.dart';
import '../../../wishlist/view/screens/wishlist_screen.dart';

class NavPage extends StatefulWidget {
  const NavPage({super.key, this.isFirstLaunch = true});

  final bool isFirstLaunch;

  @override
  NavPageState createState() => NavPageState();
}

class NavPageState extends State<NavPage> {
  bool _isFirstLaunch = true; // Variable to track first launch
  int _selectedIndex = 0; // Track the selected index of the BottomNavigationBar
  int tutorialScreenIndex = 0;

  // IMP : Flutter will create the widgets com list eagerly resulting com controller
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
    setState(() {
      _selectedIndex = index;
    });
  }

  void changeIndexTutorial() {
    setState(() {
      tutorialScreenIndex += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundColor.white,
      body: SafeArea(
        child: Stack(
          children: [
            _getScreen(_selectedIndex), // Display the selected page
            if (tutorialScreenIndex < 14 && !_isFirstLaunch)
              Positioned.fill(
                child: TutorialScreen(
                  index: tutorialScreenIndex,
                  onTap: changeIndexTutorial,
                ),
              ),
          ],
        ),
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
              icon: Icon(Icons.home_outlined, size: 30),
              activeIcon: Icon(Icons.home, size: 30),
              label: '',
              backgroundColor: BottomNavigationColor.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined, size: 30),
              activeIcon: Icon(Icons.search, size: 30),
              label: '',
              backgroundColor: BottomNavigationColor.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined, size: 30),
              activeIcon: Icon(Icons.shopping_cart_rounded, size: 30),
              label: '',
              backgroundColor: BottomNavigationColor.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border, size: 30),
              activeIcon: Icon(Icons.favorite, size: 30),
              label: '',
              backgroundColor: BottomNavigationColor.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_outlined, size: 30),
              activeIcon: Icon(Icons.person, size: 30),
              label: '',
              backgroundColor: BottomNavigationColor.white)
        ],
      ),
    );
  }
}
