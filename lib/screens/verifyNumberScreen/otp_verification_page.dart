import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:slide_to_act/slide_to_act.dart';

class OTPVerificationPage extends StatefulWidget {
  final bool? otpVerified;
  final bool? numberExist;
  final String? myNumber;
  final String? email;
  const OTPVerificationPage({
    Key? key,
    @required this.otpVerified,
    @required this.numberExist,
    @required this.myNumber,
    @required this.email,
  }) : super(key: key);

  @override
  _OTPVerificationPageState createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage>
    with TickerProviderStateMixin {
  final GlobalKey<SlideActionState> _key = GlobalKey();

  TextEditingController textEditingController1 = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();
  StreamController<ErrorAnimationType>? errorController1;
  StreamController<ErrorAnimationType>? errorController2;

  bool hasError = false;
  String phone_otp = "";
  String email_otp = "";
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();

  bool timeReached = true;
  final int timerMaxSeconds = 30;
  int currentSeconds = 0;
  final interval = const Duration(seconds: 1);

  String get timerText =>
      '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}: ${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';

  startTimeout([int? milliseconds]) {
    var duration = interval;
    Timer.periodic(duration, (timer) {
      setState(() {
        // print(timer.tick);
        currentSeconds = timer.tick;
        if (timer.tick >= timerMaxSeconds) {
          timer.cancel();
          setState(() {
            timeReached = true;
          });
        }
      });
    });
  }

  AnimationController? _animationController;

  double? _containerPaddingLeft = 20.0;
  double? _animationValue;
  double? _translateX = 0;
  double? _translateY = 0;
  double? _rotate = 0;
  double? _scale = 1;

  bool show = false;
  bool sent = false;
  Color _color = Colors.lightBlue;

  @override
  void initState() {
    errorController1 = StreamController<ErrorAnimationType>();
    errorController2 = StreamController<ErrorAnimationType>();
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1300));
    show = true;
    _animationController!.addListener(() {
      setState(() {
        show = false;
        _animationValue = _animationController!.value;
        if (_animationValue! >= 0.2 && _animationValue! < 0.4) {
          _containerPaddingLeft = 100.0;
          _color = Colors.green;
        } else if (_animationValue! >= 0.4 && _animationValue! <= 0.5) {
          _translateX = 80.0;
          _rotate = -20.0;
          _scale = 0.1;
        } else if (_animationValue! >= 0.5 && _animationValue! <= 0.8) {
          _translateY = -20.0;
        } else if (_animationValue! >= 0.81) {
          _containerPaddingLeft = 20.0;
          sent = true;
        }
      });
    });
  }

  // snackBar Widget
  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushReplacementNamed('/landingPage/VerifyNumber');
        //we need to return a future
        return Future.value(false);
      },
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width / 6,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Text(
                      "Enter Verification Code\n sent to:\n\n " +
                          widget.myNumber.toString() +
                          "\n" +
                          widget.email.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Phone OTP",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Form(
                  key: formKey1,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 30),
                      child: PinCodeTextField(
                        appContext: context,
                        pastedTextStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        length: 6,
                        obscureText: true,
                        useHapticFeedback: true,
                        hapticFeedbackTypes: HapticFeedbackTypes.vibrate,
                        obscuringCharacter: '•',
                        // obscuringWidget: FlutterLogo(
                        //   size: 24,
                        // ),
                        blinkWhenObscuring: true,
                        animationType: AnimationType.fade,
                        validator: (v) {
                          if (v!.length < 3) {
                            return "I'm from AI validator";
                          } else {
                            return null;
                          }
                        },
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          fieldWidth: 40,
                          activeFillColor: Colors.white,
                        ),
                        cursorColor: Colors.black,
                        animationDuration: Duration(milliseconds: 300),
                        enableActiveFill: true,
                        errorAnimationController: errorController1,
                        controller: textEditingController1,
                        keyboardType: TextInputType.number,
                        boxShadows: [
                          BoxShadow(
                            offset: Offset(0, 1),
                            color: Colors.black12,
                            blurRadius: 10,
                          )
                        ],
                        onCompleted: (v) {
                          print("Completed");
                        },
                        // onTap: () {
                        //   print("Pressed");
                        // },
                        onChanged: (value) {
                          print(value);
                          setState(() {
                            phone_otp = value;
                          });
                        },
                        beforeTextPaste: (text) {
                          print("Allowing to paste $text");
                          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                          //but you can show anything you want here, like your pop up saying wrong paste format or etc
                          return true;
                        },
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Email OTP",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Form(
                  key: formKey2,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 30),
                      child: PinCodeTextField(
                        appContext: context,
                        pastedTextStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        length: 6,
                        obscureText: true,
                        useHapticFeedback: true,
                        hapticFeedbackTypes: HapticFeedbackTypes.vibrate,
                        obscuringCharacter: '•',
                        // obscuringWidget: FlutterLogo(
                        //   size: 24,
                        // ),
                        blinkWhenObscuring: true,
                        animationType: AnimationType.fade,
                        validator: (v) {
                          if (v!.length < 3) {
                            return "I'm from AI validator";
                          } else {
                            return null;
                          }
                        },
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          fieldWidth: 40,
                          activeFillColor: Colors.white,
                        ),
                        cursorColor: Colors.black,
                        animationDuration: Duration(milliseconds: 300),
                        enableActiveFill: true,
                        errorAnimationController: errorController2,
                        controller: textEditingController2,
                        keyboardType: TextInputType.number,
                        boxShadows: [
                          BoxShadow(
                            offset: Offset(0, 1),
                            color: Colors.black12,
                            blurRadius: 10,
                          )
                        ],
                        onCompleted: (v) {
                          print("Completed");
                        },
                        // onTap: () {
                        //   print("Pressed");
                        // },
                        onChanged: (value) {
                          print(value);
                          setState(() {
                            email_otp = value;
                          });
                        },
                        beforeTextPaste: (text) {
                          print("Allowing to paste $text");
                          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                          //but you can show anything you want here, like your pop up saying wrong paste format or etc
                          return true;
                        },
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    hasError ? "*Please fill up all the cells properly" : "",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Didn't receive the code? ",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    timeReached
                        ? TextButton(
                            onPressed: () {
                              setState(() {
                                timeReached = false;
                                startTimeout();
                                snackBar("OTP sent successfully");
                              });
                            },
                            child: Text(
                              "RESEND",
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          )
                        : Text(
                            timerText,
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                  ],
                ),
                // Container(
                //   margin:
                //       const EdgeInsets.symmetric(vertical: 30.0, horizontal: 100),
                //   child: ButtonTheme(
                //     height: 50,
                //     child: TextButton(
                //       onPressed: () {
                //         formKey.currentState!.validate();
                //         // conditions for validating
                //         if (currentText.length != 6 || currentText != "123456") {
                //           errorController!.add(ErrorAnimationType
                //               .shake); // Triggering error shake animation
                //           setState(() => hasError = true);
                //         } else {
                //           setState(
                //             () {
                //               hasError = false;
                //               snackBar("Number Verified! Swipe to Proceed!");
                //             },
                //           );
                //         }
                //       },
                //       child: Center(
                //           child: Text(
                //         "VERIFY".toUpperCase(),
                //         style: TextStyle(
                //             color: Colors.white,
                //             fontSize: 18,
                //             fontWeight: FontWeight.bold),
                //       )),
                //     ),
                //   ),
                //   decoration: BoxDecoration(
                //     color: Colors.green,
                //     borderRadius: BorderRadius.circular(5),
                //   ),
                // ),

                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 20),
                  child: GestureDetector(
                    onTap: () {
                      formKey1.currentState!.validate();
                      formKey2.currentState!.validate();
                      // conditions for validating
                      if (phone_otp.length != 6 || phone_otp != "123456") {
                        errorController1!.add(ErrorAnimationType
                            .shake); // Triggering error shake animation

                        setState(() => {
                              hasError = true,
                            });
                        textEditingController1.clear();
                      }
                      if (email_otp.length != 6 || email_otp != "123456") {
                        errorController2!.add(ErrorAnimationType
                            .shake); // Triggering error shake animation

                        setState(() => {
                              hasError = true,
                            });
                        textEditingController2.clear();
                      } else {
                        setState(
                          () {
                            hasError = false;
                            _animationController!.forward();
                            snackBar(
                                "Number and Email Verified! Swipe to Proceed!");
                          },
                        );
                      }
                    },
                    child: AnimatedContainer(
                      decoration: BoxDecoration(
                        color: _color,
                        borderRadius: BorderRadius.circular(100.0),
                        boxShadow: [
                          BoxShadow(
                            color: _color,
                            blurRadius: 21,
                            spreadRadius: -15,
                            offset: Offset(
                              0.0,
                              20.0,
                            ),
                          )
                        ],
                      ),
                      padding: EdgeInsets.only(
                          left: _containerPaddingLeft!,
                          right: 20.0,
                          top: 10.0,
                          bottom: 10.0),
                      duration: Duration(milliseconds: 400),
                      curve: Curves.easeOutCubic,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          (!sent)
                              ? AnimatedContainer(
                                  duration: Duration(milliseconds: 400),
                                  child: Icon(Icons.send),
                                  curve: Curves.fastOutSlowIn,
                                  transform: Matrix4.translationValues(
                                      _translateX!, _translateY!, 0)
                                    ..rotateZ(_rotate!)
                                    ..scale(_scale),
                                )
                              : Container(),
                          AnimatedSize(
                            vsync: this,
                            duration: Duration(milliseconds: 600),
                            child: show ? SizedBox(width: 10.0) : Container(),
                          ),
                          AnimatedSize(
                            vsync: this,
                            duration: Duration(milliseconds: 200),
                            child: show ? Text("Verify") : Container(),
                          ),
                          AnimatedSize(
                            vsync: this,
                            duration: Duration(milliseconds: 200),
                            child: sent ? Icon(Icons.done) : Container(),
                          ),
                          AnimatedSize(
                            vsync: this,
                            alignment: Alignment.topLeft,
                            duration: Duration(milliseconds: 600),
                            child: sent ? SizedBox(width: 10.0) : Container(),
                          ),
                          AnimatedSize(
                            vsync: this,
                            duration: Duration(milliseconds: 200),
                            child: sent ? Text("Done") : Container(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    child: SlideAction(
                      text: widget.numberExist!
                          ? "Swipe to sign in"
                          : "Register an account",
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
                        if (phone_otp.length != 6 || phone_otp != "123456") {
                          errorController1!.add(ErrorAnimationType
                              .shake); // Triggering error shake animation
                          setState(() => hasError = true);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OTPVerificationPage(
                                numberExist: widget.numberExist,
                                myNumber: widget.myNumber,
                                email: widget.email,
                              ),
                            ),
                          );
                        } else if (email_otp.length != 6 ||
                            email_otp != "123456") {
                          errorController2!.add(ErrorAnimationType
                              .shake); // Triggering error shake animation
                          setState(() => hasError = true);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OTPVerificationPage(
                                numberExist: widget.numberExist,
                                myNumber: widget.myNumber,
                                email: widget.email,
                              ),
                            ),
                          );
                        } else {
                          widget.numberExist!
                              ? Navigator.pushNamedAndRemoveUntil(
                                  context, '/home/Main', (route) => false)
                              : Navigator.pushNamedAndRemoveUntil(context,
                                  '/RegisterAccount', ((route) => false));
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    errorController1!.close();
    errorController2!.close();
    errorController1 = null;
    errorController2 = null;
    _animationController!.dispose();
    super.dispose();
  }
}
