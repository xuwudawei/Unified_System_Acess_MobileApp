// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:usa_app/colors.dart';
import 'package:usa_app/providers/bottomNav.dart';
import 'package:usa_app/providers/productListProvider.dart';
import 'package:usa_app/routes/routes.dart';
import 'package:usa_app/screens/initialScreens/splash_screen.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => BottomNavigationProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductListProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        onGenerateRoute: RouteGenerator.generateRoute,
        theme: ThemeData(
            scaffoldBackgroundColor: HexColor(lightDark),
            primaryColor: HexColor(lightDark)),
      ),
    );
  }
}
