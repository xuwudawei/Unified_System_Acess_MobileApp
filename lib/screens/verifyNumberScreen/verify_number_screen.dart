import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:email_validator/email_validator.dart' as vd;
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
  String email = '';
  String? validEmail;

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
    } else if (!vd.EmailValidator.validate(email)) {
      return 'Please enter a valid email';
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
                height: MediaQuery.of(context).size.width / 4,
              ),
              Container(
                padding: const EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text(
                    "Verify Your Email and Phone Number",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 10,
                  left: 20,
                  right: 20,
                  // bottom: MediaQuery.of(context).size.width / 20,
                ),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.always,
                  style: TextStyle(color: Colors.white, fontSize: 23),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    isDense: true,
                    border: OutlineInputBorder(),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.grey),
                    hintText: 'Email',
                    suffixText: 'Required',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  validator: (emails) => validEmail,
                  onChanged: (emails) {
                    if (vd.EmailValidator.validate(emails)) {
                      setState(() {
                        email = emails;
                        validEmail = null;
                      });
                    } else {
                      setState(() {
                        validEmail = 'Please enter a valid email';
                      });
                    }
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 150,
                  bottom: MediaQuery.of(context).size.width / 2,
                  left: 20,
                  right: 20,
                ),
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
                                      myNumber: myNumber,
                                      email: email))
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
