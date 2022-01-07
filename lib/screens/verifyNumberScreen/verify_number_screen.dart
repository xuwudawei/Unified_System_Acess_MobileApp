import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:usa_app/screens/verifyNumberScreen/otp_verification_page.dart';

class VerifyNumberPage extends StatefulWidget {
  const VerifyNumberPage({Key? key}) : super(key: key);

  @override
  _VerifyNumberPageState createState() => _VerifyNumberPageState();
}

class _VerifyNumberPageState extends State<VerifyNumberPage> {
  var myNumber = "";
  var numberList = ["+2251234567890", "+2331234567890"];
  bool numberExist = false;

  final GlobalKey<SlideActionState> _key = GlobalKey();

  // snackBar Widget
  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: Duration(seconds: 2),
      ),
    );
  }

  //Phone Number Validation
  String validateMobile(String value) {
    String pattern = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return 'Please enter your mobile number';
    } else if (!regExp.hasMatch(value) || value.length < 10) {
      // print(regExp.hasMatch(value));
      return 'Invalid mobile number, Try again!';
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width / 3,
              ),
              Container(
                padding: const EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text(
                    "Verify Your Phone Number",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.width / 2.6),
                child: Container(
                  // color: Colors.white,
                  height: 120,
                  padding: EdgeInsets.all(5),
                  child: IntlPhoneField(
                    keyboardType: TextInputType.phone,
                    countryCodeTextColor: Colors.white,
                    initialValue: '',
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      labelStyle: TextStyle(color: Colors.white, fontSize: 24),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                    initialCountryCode: 'GH',
                    // onSubmitted: (value) async {
                    //   FocusScope.of(context).unfocus();
                    // },
                    onChanged: (phone) {
                      myNumber = phone.completeNumber.toString();
                      // print(phone.completeNumber);
                    },
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 6,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: SlideAction(
                    text: " Swipe to receive OTP >>",
                    textStyle: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                    ),
                    //sliderButtonIconPadding: 8,
                    key: _key,
                    height: 85,
                    outerColor: HexColor("#083473"),
                    sliderButtonIconSize: 38,
                    //animationDuration: Duration(seconds: 1),
                    reversed: false,
                    onSubmit: () {
                      numberExist = numberList.contains(myNumber);
                      if (numberExist) {
                        print("My number is " +
                            numberList
                                .where((num) => num == myNumber)
                                .toList()
                                .first);
                        print("what i entered is " + myNumber);
                        print(numberExist);
                        setState(
                          () {
                            snackBar(
                              "Number Exist, proceed to sign in",
                            );
                          },
                        );
                        //Submit Number for Background verification
                        //If exist, show signin on the top
                        //If doesn't exist, then go to regsiter page
                        Future.delayed(
                          Duration(seconds: 2),
                          () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OTPVerificationPage(
                                      numberExist: numberExist,
                                      myNumber: myNumber))
                              // '/VerifyNumber/OTP',
                              // (route) => false,
                              // arguments: numberExist,
                              ),
                        );
                      } else {
                        if (validateMobile(myNumber) == '') {
                          setState(() {
                            snackBar(
                              "This is a new number. Proceed to register an account!",
                            );
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OTPVerificationPage(
                                      numberExist: numberExist,
                                      myNumber: myNumber))
                              // '/VerifyNumber/OTP',
                              // (route) => false,
                              // arguments: numberExist,
                              );
                        } else {
                          setState(() {
                            snackBar(validateMobile(myNumber));
                          });
                          Navigator.pushNamedAndRemoveUntil(context,
                              '/landingPage/VerifyNumber', (route) => false);
                        }
                      }
                    },
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
