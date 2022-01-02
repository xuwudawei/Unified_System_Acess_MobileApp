import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:usa_app/data/productData.dart';
import 'package:usa_app/models/product_model.dart';
import 'package:usa_app/providers/productListProvider.dart';
import 'package:usa_app/screens/home/homePageProductTile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textController = TextEditingController();
  var _searchview = new TextEditingController();
  List<ProductModel> allProducts = GetAllProducts();
  TabController? controller;
  bool _firstSearch = true;
  String _query = "";

  List<String>? _nebulae;
  List<String>? _filterList;
  @override
  void initState() {
    super.initState();
    //controller = new TabController(length: 4, vsync: this.);
    _nebulae = [];
    for (var a in allProducts) {
      _nebulae!.add(a.productName!.toLowerCase());
    }
  }

  _HomePageState() {
    //Register a closure to be called when the object changes.
    _searchview.addListener(() {
      // print(_searchview.text);
      if (_searchview.text.isEmpty) {
        //Notify the framework that the internal state of this object has changed.
        setState(() {
          _firstSearch = true;
          _query = "";
        });
      } else {
        setState(() {
          _firstSearch = false;
          _query = _searchview.text;
          // print(_query);
          // print("My search query is " + _query);
        });
      }
    });
  }

  Widget _createSearchView() {
    return new Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      //decoration: BoxDecoration(border: Border.all(width: 1.0)),
      child: new TextField(
        controller: _searchview,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: "Search",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide.none,
          ),
          fillColor: Color(0xffe6e6ec),
          filled: true,
        ),
      ),
    );
  }

  Widget _createListView() {
    return new Flexible(
      child: new ListView.builder(
          itemCount: _nebulae!.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: ProductTile(
                productName: allProducts[index].productName,
                productImage: allProducts[index].productImage,
                date: allProducts[index].date,
                productDescription: allProducts[index].productDescription,
                acccountStatus: allProducts[index].accountStatus,
              ),
            );
          }),
    );
  }

  Widget _performSearch() {
    _filterList = [];

    for (int i = 0; i < _nebulae!.length; i++) {
      var item = _nebulae![i];
      // print(item + " " + _query);
      if (item.toLowerCase().contains(_query.toLowerCase())) {
        _filterList!.add(item);
      }
    }

    return _createFilteredListView();
  }

  Widget _createFilteredListView() {
    List<ProductModel> finalList = [];
    for (var b in _filterList!) {
      allProducts.forEach((w) {
        if (w.productName!.toLowerCase().contains(b)) {
          finalList.add(w);
          // print(w);

          // print(_query);
        }
      });
    }
    // print(finalList);

    return new Flexible(
      child: new ListView.builder(
          itemCount: finalList.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: ProductTile(
                productName: finalList[index].productName,
                productImage: finalList[index].productImage,
                date: finalList[index].date,
                productDescription: finalList[index].productDescription,
                acccountStatus: finalList[index].accountStatus,
              ),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final productListProv = Provider.of<ProductListProvider>(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            // AnimSearchBar(()
            //   width: MediaQuery.of(context).size.width * 0.95,
            //   textController: textController,
            //   helpText: "Search anything",
            //   color: HexColor("#fe8a71"),
            //   style: TextStyle(
            //     color: Colors.black,
            //     fontSize: 20,
            //   ),
            //   closeSearchOnSuffixTap: true,
            //   onSuffixTap: () {
            //     setState(() {
            //       // FocusScope.of(context).unfocus();

            //       print(textController.text);
            //       textController.clear();
            //     });
            //   },
            // ),
          ],
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Center(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: SizedBox(
                      child: DefaultTextStyle(
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 18.5,
                          fontFamily: 'Agne',
                          fontWeight: FontWeight.bold,
                        ),
                        child: AnimatedTextKit(
                          animatedTexts: [
                            TypewriterAnimatedText('Hi, David'),
                            TypewriterAnimatedText(
                                'Welcome to Unified System Access'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _createSearchView(),
                  SizedBox(
                    height: 10,
                  ),
                  _firstSearch ? _createListView() : _performSearch(),
                  // Container(
                  //   child: Expanded(
                  //     child: ListView.builder(
                  //       itemCount: productListProv.getAllProducts.length,
                  //       shrinkWrap: true,
                  //       physics: const AlwaysScrollableScrollPhysics(),
                  //       itemBuilder: (context, index) {
                  //         return Container(
                  //           child: ProductTile(
                  //             productName:
                  //                 productListProv.getAllProducts[index].productName,
                  //             productImage: productListProv
                  //                 .getAllProducts[index].productImage,
                  //             date: productListProv.getAllProducts[index].date,
                  //             productDescription: productListProv
                  //                 .getAllProducts[index].productDescription,
                  //             acccountStatus: productListProv
                  //                 .getAllProducts[index].accountStatus,
                  //           ),
                  //         );
                  //       },
                  //     ),
                  //   ),
                  // ),

                  //I have removed the background circular design for the sake of simplicity

                  // Container(
                  //   child: Expanded(
                  //     child: Stack(
                  //       children: [
                  //         Column(
                  //           children: [
                  //             Container(
                  //               width: 200,
                  //               height: 200,
                  //               margin: EdgeInsets.only(
                  //                   left: MediaQuery.of(context).size.width / 2.4),
                  //               decoration: BoxDecoration(
                  //                   gradient: LinearGradient(
                  //                     colors: [
                  //                       Colors.pink.shade700,
                  //                       Colors.orange.shade500
                  //                     ],
                  //                     begin: Alignment.topRight,
                  //                     end: Alignment.bottomLeft,
                  //                   ),
                  //                   borderRadius: BorderRadius.circular(100)),
                  //             ),
                  //             Container(
                  //               width: 100,
                  //               height: 100,
                  //               margin: EdgeInsets.only(
                  //                   right: MediaQuery.of(context).size.width / 2.4),
                  //               decoration: BoxDecoration(
                  //                   gradient: LinearGradient(
                  //                     colors: [
                  //                       Colors.pink.shade700,
                  //                       Colors.orange.shade500
                  //                     ],
                  //                     begin: Alignment.topRight,
                  //                     end: Alignment.bottomLeft,
                  //                   ),
                  //                   borderRadius: BorderRadius.circular(100)),
                  //             ),
                  //             Container(
                  //               width: 200,
                  //               height: 200,
                  //               margin: EdgeInsets.only(
                  //                   left: MediaQuery.of(context).size.width / 2.4),
                  //               decoration: BoxDecoration(
                  //                   gradient: LinearGradient(
                  //                     colors: [
                  //                       Colors.pink.shade700,
                  //                       Colors.orange.shade500
                  //                     ],
                  //                     begin: Alignment.topRight,
                  //                     end: Alignment.bottomLeft,
                  //                   ),
                  //                   borderRadius: BorderRadius.circular(100)),
                  //             ),
                  //             Container(
                  //               width: 100,
                  //               height: 100,
                  //               margin: EdgeInsets.only(
                  //                   right: MediaQuery.of(context).size.width / 2.4),
                  //               decoration: BoxDecoration(
                  //                   gradient: LinearGradient(
                  //                     colors: [
                  //                       Colors.pink.shade700,
                  //                       Colors.orange.shade500
                  //                     ],
                  //                     begin: Alignment.topRight,
                  //                     end: Alignment.bottomLeft,
                  //                   ),
                  //                   borderRadius: BorderRadius.circular(100)),
                  //             ),
                  //           ],
                  //         ),
                  //         // ListView.builder(
                  //         //   itemCount: productListProv.getAllProducts.length,
                  //         //   shrinkWrap: true,
                  //         //   physics: const AlwaysScrollableScrollPhysics(),
                  //         //   itemBuilder: (context, index) {
                  //         //     return Container(
                  //         //       child: ProductTile(
                  //         //         productName: productListProv
                  //         //             .getAllProducts[index].productName,
                  //         //         productImage: productListProv
                  //         //             .getAllProducts[index].productImage,
                  //         //         date: productListProv.getAllProducts[index].date,
                  //         //         productDescription: productListProv
                  //         //             .getAllProducts[index].productDescription,
                  //         //         acccountStatus: productListProv
                  //         //             .getAllProducts[index].accountStatus,
                  //         //       ),
                  //         //     );
                  //         //   },
                  //         // ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
