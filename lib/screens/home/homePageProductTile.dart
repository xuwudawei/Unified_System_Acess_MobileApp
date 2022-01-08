import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({
    Key? key,
    required this.acccountStatus,
    required this.appName,
    required this.date,
    required this.sessionId,
  }) : super(key: key);
  final int? acccountStatus;
  final String? appName;
  final String? sessionId;
  final DateTime? date;

  @override
  Widget build(BuildContext context) {
    List<Color> _accountColors = [
      Colors.green.withOpacity(0.25),
      Colors.orange.withOpacity(0.25),
      Colors.red.withOpacity(0.25),
      Colors.blue.withOpacity(0.25),
    ];
    final _random = Random();

    Color? _detectAccountBackgroundColor() {
      return _accountColors[_random.nextInt(_accountColors.length)];
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.24,
      width: MediaQuery.of(context).size.width / 1.07,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: _detectAccountBackgroundColor()!,
            )
          ],
          border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.0),
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
                    appName!,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontWeight: FontWeight.bold,
                        fontSize: 19),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  // width: MediaQuery.of(context).size.width / 3.8,
                  child: Row(
                    children: [
                      // Text(
                      //   "6372",
                      //   style: TextStyle(
                      //       color: Colors.white.withOpacity(0.5),
                      //       fontSize: 12),
                      // // ),
                      // SizedBox(
                      //   width: 10,
                      // ),
                      Text(
                        "Date Created: ",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.5),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        DateFormat.yMMMEd().format(date!),
                        style: TextStyle(
                            fontSize: 14, color: Colors.white.withOpacity(0.5)),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Session Id: " + sessionId!,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.5),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  // width: 100,
                  child: Text(
                    "Status:",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.6),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      // Icon(
                      //   Icons.lock_outline,
                      //   color: _detectAccountColor()!,
                      // ),
                      Text(
                        (acccountStatus! == 1 ? "Connected" : "Disconnected"),
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Image.asset(
              "assets/images/app_logo.jpeg",
              height: MediaQuery.of(context).size.width / 10,
            ),
          ],
        ),
      ),
    );
  }
}
