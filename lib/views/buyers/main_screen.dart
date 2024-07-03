import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multivendor_ecommerce_app/views/buyers/nav_screens/account_screen.dart';
import 'package:multivendor_ecommerce_app/views/buyers/nav_screens/cart_screen.dart';
import 'package:multivendor_ecommerce_app/views/buyers/nav_screens/category_screen.dart';
import 'package:multivendor_ecommerce_app/views/buyers/nav_screens/home_screen.dart';
import 'package:multivendor_ecommerce_app/views/buyers/nav_screens/search_screen.dart';
import 'package:multivendor_ecommerce_app/views/buyers/nav_screens/store_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _pageIndex = 0;

  List<Widget> _pages = [
    HomeScreen(),
    CategoryScreen(),
    StoreScreen(),
    CartScreen(),
    SearchScreen(),
    AccountScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        // type: BottomNavigationBarType.fixed,
        //bottomnavbar horizontally moves, if want to remove it then do fixed
        currentIndex: _pageIndex,
        onTap: (value) {
          setState(() {
            _pageIndex = value;
          });
        },
        unselectedItemColor: Color.fromARGB(255, 245, 167, 99),

        selectedItemColor: Color.fromARGB(255, 245, 167, 99),

        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/explore.svg',
              color: Color.fromARGB(255, 245, 167, 99),
              width: 20,
            ),
            label: 'CATEGORIES',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/shop.svg',
              color: Color.fromARGB(255, 245, 167, 99),
              width: 20,
            ),
            label: 'STORE',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/cart.svg',
              color: Color.fromARGB(255, 245, 167, 99),
              width: 20,
            ),
            label: 'CART',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/search.svg',
              color: Color.fromARGB(255, 245, 167, 99),
              width: 20,
            ),
            label: 'SEARCH',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              color: Color.fromARGB(255, 245, 167, 99),
              'assets/icons/account.svg',
              width: 20,
            ),
            label: 'ACCOUNT',
          ),
        ],
      ),
      body: _pages[_pageIndex], //to display home screens.
    );
  }
}
