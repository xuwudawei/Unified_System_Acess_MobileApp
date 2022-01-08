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
  const HomePage({Key? key, required}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // controller = new TabController(length: 4, vsync: this.);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final productListProv =
        Provider.of<ProductListProvider>(context, listen: false);
    List<ProductModel> allProducts = productListProv.getAllProducts();
    _nebulae = [];
    for (var a in allProducts) {
      _nebulae!.add(a.appName!.toLowerCase());
    }
    // print(_nebulae);
  }

  TextEditingController textController = TextEditingController();
  var _searchview = new TextEditingController();

  TabController? controller;
  bool _firstSearch = true;
  String _query = "";

  List<String>? _nebulae;
  List<String>? _filterList;

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
      child: new TextFormField(
        autofocus: false,
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
    final productListProv = Provider.of<ProductListProvider>(context);
    List<ProductModel> allProducts = productListProv.getAllProducts();
    return new Flexible(
      child: new ListView.builder(
          itemCount: _nebulae!.length,
          itemBuilder: (BuildContext context, int index) {
            return Center(
              child: Container(
                padding: EdgeInsets.only(bottom: 15),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    child: Stack(
                      children: [
                        BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 7,
                            sigmaY: 7,
                          ),
                        ),
                        Container(
                          child: ProductTile(
                            appName: allProducts[index].appName,
                            sessionId: allProducts[index].sessionId,
                            date: allProducts[index].date,
                            acccountStatus: allProducts[index].accountStatus,
                          ),
                        ),
                        Positioned(
                          top: 20.0,
                          right: 10.0,
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Unsubscribe'),
                                    content: Text(
                                        'Are you sure you want to unsubscribe?'),
                                    actions: [
                                      FlatButton(
                                        child: Text('Unsubscribe'),
                                        onPressed: () {
                                          productListProv
                                              .setProductAccountStatusInactive(
                                                  index);
                                          setState(() {
                                            allProducts.removeAt(index);
                                          });
                                          print("removed");
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      FlatButton(
                                        child: Text('Cancel'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Icon(
                              Icons.settings,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget _performSearch() {
    final productListProv = Provider.of<ProductListProvider>(context);
    List<ProductModel> allProducts = productListProv.getAllProducts();
    _filterList = [];

    for (int i = 0; i < _nebulae!.length; i++) {
      var item = _nebulae![i];
      // print(item + " " + _query);
      if (item.toLowerCase().contains(_query.toLowerCase())) {
        _filterList!.add(item);
      }
    }
    // print(_filterList);

    return _createFilteredListView(allProducts);
  }

  Widget _createFilteredListView(List<ProductModel> allProducts) {
    final productListProv = Provider.of<ProductListProvider>(context);
    List<ProductModel> allProducts = productListProv.getAllProducts();

    List<ProductModel> finalList = [];

    for (var b in _filterList!) {
      allProducts.forEach((w) {
        if (w.appName!.toLowerCase().contains(b)) {
          finalList.add(w);
          // print(w);

          // print(_query);
        }
      });
    }
    // print(finalList[0].appName);

    return new Flexible(
      child: new ListView.builder(
          itemCount: finalList.length,
          itemBuilder: (BuildContext context, int index) {
            return Center(
              child: Container(
                padding: EdgeInsets.only(bottom: 15),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    child: Stack(
                      children: [
                        BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 7,
                            sigmaY: 7,
                          ),
                        ),
                        Container(
                          child: ProductTile(
                            appName: finalList[index].appName,
                            sessionId: finalList[index].sessionId,
                            date: finalList[index].date,
                            acccountStatus: finalList[index].accountStatus,
                          ),
                        ),
                        Positioned(
                          top: 20.0,
                          right: 10.0,
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Unsubscribe'),
                                    content: Text(
                                        'Are you sure you want to unsubscribe?'),
                                    actions: [
                                      FlatButton(
                                        child: Text('Unsubscribe'),
                                        onPressed: () {
                                          productListProv
                                              .setProductAccountStatusInactive(
                                                  index);
                                          setState(() {
                                            finalList.removeAt(index);
                                          });
                                          print("removed");
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      FlatButton(
                                        child: Text('Cancel'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Icon(
                              Icons.settings,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [],
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
