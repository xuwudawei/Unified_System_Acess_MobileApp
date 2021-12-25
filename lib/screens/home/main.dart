import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usa_app/providers/bottomNav.dart';
import 'package:usa_app/screens/home/homePage.dart';
import 'package:usa_app/screens/home/profilePage.dart';

class PageController extends StatefulWidget {
  const PageController({Key? key}) : super(key: key);

  @override
  _PageControllerState createState() => _PageControllerState();
}

class _PageControllerState extends State<PageController> {
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

  @override
  Widget build(BuildContext context) {
    BottomNavigationProvider botNav =
        Provider.of<BottomNavigationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
