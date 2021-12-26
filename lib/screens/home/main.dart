import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:usa_app/colors.dart';
import 'package:usa_app/data/productData.dart';
import 'package:usa_app/models/product_model.dart';
import 'package:usa_app/providers/bottomNav.dart';
import 'package:usa_app/providers/productListProvider.dart';
import 'package:usa_app/screens/home/homePage.dart';
import 'package:usa_app/screens/home/profilePage.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    fetchProductList();
  }

  var selectedNav = 0;
  List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    BottomNavigationProvider bottomNav =
        Provider.of<BottomNavigationProvider>(context, listen: false);
    bottomNav.setIndex(index);
  }

  Future<void> fetchProductList() async {
    var productListData =
        Provider.of<ProductListProvider>(context, listen: false);
    List<ProductModel> products = await GetAllProducts();
    productListData.setProductList(products);
    print(products);
  }

  @override
  Widget build(BuildContext context) {
    BottomNavigationProvider botNav =
        Provider.of<BottomNavigationProvider>(context);
    return Scaffold(
      body: _widgetOptions.elementAt(botNav.getDefaultIndex()),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: HexColor(lightDark),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              rippleColor: Colors.blueAccent,
              hoverColor: Colors.blueAccent,
              gap: 0,
              activeColor: Colors.black,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.blueAccent,
              color: Colors.black,
              tabs: [
                GButton(
                  iconActiveColor: Colors.white,
                  icon: LineIcons.home,
                  text: "Home",
                  textColor: Colors.white,
                  iconColor: Colors.white,
                ),
                GButton(
                  icon: LineIcons.user,
                  iconActiveColor: Colors.white,
                  text: 'Profile',
                  iconColor: Colors.white,
                  textColor: Colors.white,
                ),
              ],
              selectedIndex: selectedNav,
              onTabChange: (value) {
                setState(() {
                  botNav.setIndex(value);
                  print(value);
                });
              },
            ),
          ),
        ),
      ),
      // MotionTabBar(
      //   labels: ["Home", "Profile"],
      //   initialSelectedTab: "Home",
      //   tabIconColor: Colors.white,
      //   tabSelectedColor: Colors.white,
      //   onTabItemSelected: (int value) {
      //     botNav.setIndex(value);
      //     print(value);
      //     setState(() {
      //       _tabController?.index = value;
      //     });
      //   },
      //   icons: [
      //     Icons.home,
      //     Icons.person,
      //   ],
      //   textStyle: TextStyle(color: Colors.white),
      // ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
