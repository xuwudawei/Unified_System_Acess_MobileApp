import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usa_app/providers/productListProvider.dart';
import 'package:usa_app/screens/home/homePageProductTile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final productListProv = Provider.of<ProductListProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: DefaultTextStyle(
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 18.5,
                  fontFamily: 'Agne',
                  fontWeight: FontWeight.bold,
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText('Hi, David'),
                    TypewriterAnimatedText('Welcome to Unified System Access'),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Expanded(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 200,
                          height: 200,
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 2.4),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.pink.shade700,
                                  Colors.orange.shade500
                                ],
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                              ),
                              borderRadius: BorderRadius.circular(100)),
                        ),
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width / 2.4),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.pink.shade700,
                                  Colors.orange.shade500
                                ],
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                              ),
                              borderRadius: BorderRadius.circular(100)),
                        ),
                        Container(
                          width: 200,
                          height: 200,
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 2.4),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.pink.shade700,
                                  Colors.orange.shade500
                                ],
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                              ),
                              borderRadius: BorderRadius.circular(100)),
                        ),
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width / 2.4),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.pink.shade700,
                                  Colors.orange.shade500
                                ],
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                              ),
                              borderRadius: BorderRadius.circular(100)),
                        ),
                      ],
                    ),
                    ListView.builder(
                      itemCount: productListProv.getAllProducts.length,
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          child: ProductTile(
                            productName: productListProv
                                .getAllProducts[index].productName,
                            productImage: productListProv
                                .getAllProducts[index].productImage,
                            date: productListProv.getAllProducts[index].date,
                            productDescription: productListProv
                                .getAllProducts[index].productDescription,
                            acccountStatus: productListProv
                                .getAllProducts[index].accountStatus,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
