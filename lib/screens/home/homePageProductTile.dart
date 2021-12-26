import 'dart:ui';

import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({
    Key? key,
    required this.acccountStatus,
    required this.productName,
    required this.productImage,
    required this.date,
    required this.productDescription,
  }) : super(key: key);
  final String? acccountStatus;
  final String? productName;
  final String? productImage;
  final String? date;
  final String? productDescription;
  @override
  Widget build(BuildContext context) {
    Color? _detectAccountColor() {
      if (acccountStatus == 'active') {
        return Colors.green.withOpacity(0.6);
      } else if (acccountStatus == 'suspended') {
        return Colors.orange.withOpacity(0.6);
      } else if (acccountStatus == 'blocked') {
        return Colors.red.withOpacity(0.6);
      } else {
        return Colors.blue.withOpacity(0.6);
      }
    }

    Color? _detectAccountBackgroundColor() {
      if (acccountStatus == 'active') {
        return Colors.green.withOpacity(0.25);
      } else if (acccountStatus == 'suspended') {
        return Colors.orange.withOpacity(0.25);
      } else if (acccountStatus == 'blocked') {
        return Colors.red.withOpacity(0.25);
      } else {
        return Colors.blue.withOpacity(0.25);
      }
    }

    return Container(
      padding: EdgeInsets.only(bottom: 20),
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
                // child: Container(
                //   height: MediaQuery.of(context).size.height * 0.3,
                //   width: MediaQuery.of(context).size.width / 2.5,
                // ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width / 1.07,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: _detectAccountBackgroundColor()!,
                      )
                    ],
                    border: Border.all(
                        color: Colors.white.withOpacity(0.2), width: 1.0),
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.5),
                        Colors.white.withOpacity(0.2)
                      ],
                      stops: [0.0, 1.0],
                    ),
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.8,
                            child: Text(
                              productName!,
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.6),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            productDescription!,
                            style: TextStyle(
                                fontSize: 23,
                                color: Colors.white.withOpacity(0.4)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.8,
                            child: Row(
                              children: [
                                Text(
                                  "6372",
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.5),
                                      fontSize: 12),
                                ),
                                SizedBox(
                                  width: 100,
                                ),
                                Text(
                                  "Date \nCreated",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white.withOpacity(0.5),
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "  " + date!,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white.withOpacity(0.5)),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 275,
                            child: Text(
                              "Status:",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white.withOpacity(0.6),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.lock_outline,
                                  color: _detectAccountColor()!,
                                ),
                                Text(" - " + acccountStatus!,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: _detectAccountColor()!,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Image.asset(
                        productImage!,
                        height: MediaQuery.of(context).size.width / 10,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
