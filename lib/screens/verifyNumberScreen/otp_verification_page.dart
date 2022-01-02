import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:slide_to_act/slide_to_act.dart';

class OTPVerificationPage extends StatefulWidget {
  final bool? otpVerified;
  final bool? numberExist;
  final String? myNumber;
  const OTPVerificationPage({
    Key? key,
    @required this.otpVerified,
    @required this.numberExist,
    @required this.myNumber,
  }) : super(key: key);

  @override
  _OTPVerificationPageState createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage>
    with TickerProviderStateMixin {
  final GlobalKey<SlideActionState> _key = GlobalKey();

  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

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
    errorController = StreamController<ErrorAnimationType>();
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

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
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
    return Scaffold(
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
                        widget.myNumber.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Form(
                key: formKey,
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
                      obscuringCharacter: '*',
                      // obscuringWidget: FlutterLogo(
                      //   size: 24,
                      // ),
                      blinkWhenObscuring: true,
                      animationType: AnimationType.fade,
                      validator: (v) {
                        if (v!.length < 3) {
                          return "I'm from validator";
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
                      errorAnimationController: errorController,
                      controller: textEditingController,
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
                          currentText = value;
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
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't receive the code? ",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  TextButton(
                      onPressed: () => snackBar("OTP Sent!"),
                      child: Text(
                        "RESEND",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ))
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
                padding: const EdgeInsets.only(top: 30.0, bottom: 60),
                child: GestureDetector(
                  onTap: () {
                    formKey.currentState!.validate();
                    // conditions for validating
                    if (currentText.length != 6 || currentText != "123456") {
                      errorController!.add(ErrorAnimationType
                          .shake); // Triggering error shake animation
                      setState(() => hasError = true);
                    } else {
                      setState(
                        () {
                          hasError = false;
                          _animationController!.forward();
                          snackBar("Number Verified! Swipe to Proceed!");
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
                height: 16,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 5,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
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
                      if (currentText.length != 6 || currentText != "123456") {
                        errorController!.add(ErrorAnimationType
                            .shake); // Triggering error shake animation
                        setState(() => hasError = true);
                        Future.delayed(
                          Duration(seconds: 2),
                          () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OTPVerificationPage(
                                      numberExist: widget.numberExist,
                                      myNumber: widget.myNumber))
                              // '/VerifyNumber/OTP',
                              // (route) => false,
                              // arguments: numberExist,
                              ),
                        );
                      } else {
                        widget.numberExist!
                            ? Future.delayed(
                                Duration(seconds: 1),
                                () => Navigator.pushNamedAndRemoveUntil(
                                    context, '/signIn', (route) => false),
                              )
                            : Future.delayed(
                                Duration(seconds: 1),
                                () => Navigator.pushNamedAndRemoveUntil(context,
                                    '/RegisterAccount', (route) => false),
                              );
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
