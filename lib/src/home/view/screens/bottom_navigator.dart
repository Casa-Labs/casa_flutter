import 'package:casaflutterapp/src/explore/view/screens/explore_screen.dart';
import 'package:casaflutterapp/src/home/view/screens/home_screen.dart';
import 'package:casaflutterapp/src/profile/view/screens/profile_screen.dart';
import 'package:casaflutterapp/utils/color_constant.dart';
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
              icon: Icon(Icons.home_outlined, size: 25),
              activeIcon: Icon(Icons.home, size: 25),
              label: '',
              backgroundColor: BottomNavigationColor.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined, size: 25),
              activeIcon: Icon(Icons.search, size: 25),
              label: '',
              backgroundColor: BottomNavigationColor.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined, size: 25),
              activeIcon: Icon(Icons.shopping_cart_rounded, size: 25),
              label: '',
              backgroundColor: BottomNavigationColor.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border, size: 25),
              activeIcon: Icon(Icons.favorite, size: 25),
              label: '',
              backgroundColor: BottomNavigationColor.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_outlined, size: 25),
              activeIcon: Icon(Icons.person, size: 25),
              label: '',
              backgroundColor: BottomNavigationColor.white)
        ],
      ),

      // =========== ERROR ============
      // This approach will not work as it does not allow Safe area to work
      // Extra spacing is present at top of persistent bottom bar
      //     PersistentTabView(
      //   context,
      //   screens: _buildScreens(),
      //   items: <PersistentBottomNavBarItem>[
      //     PersistentBottomNavBarItem(
      //         icon: Icon(Icons.home, size: 25),
      //         inactiveIcon: Icon(Icons.home_outlined, size: 25),
      //         activeColorPrimary: Colors.black),
      //     PersistentBottomNavBarItem(
      //         icon: Icon(Icons.search, size: 25),
      //         inactiveIcon: Icon(Icons.search_outlined, size: 25),
      //         activeColorPrimary: Colors.black),
      //     PersistentBottomNavBarItem(
      //         icon: Icon(Icons.shopping_cart_rounded, size: 25),
      //         inactiveIcon: Icon(Icons.shopping_cart_outlined, size: 25),
      //         activeColorPrimary: Colors.black),
      //     PersistentBottomNavBarItem(
      //         icon: Icon(Icons.favorite, size: 25),
      //         inactiveIcon: Icon(Icons.favorite_border, size: 25),
      //         activeColorPrimary: Colors.black),
      //     PersistentBottomNavBarItem(
      //         icon: Icon(Icons.person, size: 25),
      //         inactiveIcon: Icon(Icons.person_outline_outlined, size: 25),
      //         activeColorPrimary: Colors.black),
      //   ],
      //   handleAndroidBackButtonPress: true,
      //   resizeToAvoidBottomInset: true,
      //   stateManagement: true,
      //   hideNavigationBarWhenKeyboardAppears: true,
      //   padding: const EdgeInsets.only(top: 8),
      //   backgroundColor: Colors.white,
      //   confineToSafeArea: true,
      //   navBarHeight: kBottomNavigationBarHeight,
      //   navBarStyle: NavBarStyle.style12,
      // ),
    );
  }

  // List<Widget> _buildScreens() {
  //   return [
  //     HomeScreen(),
  //     ExploreScreen(),
  //     CartScreen(),
  //     WishlistScreen(),
  //     ProfileScreen()
  //   ];
  // }
}
