import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:particles_flutter/particles_flutter.dart';
import 'package:slide_to_act/slide_to_act.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final GlobalKey<SlideActionState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: UniqueKey(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            CircularParticle(
              // key: UniqueKey(),
              awayRadius: 300,
              numberOfParticles: 70,
              speedOfParticles: 1,
              height: screenHeight,
              width: screenWidth,
              onTapAnimation: true,
              particleColor: Colors.white.withAlpha(150),
              awayAnimationDuration: Duration(milliseconds: 8000),
              maxParticleSize: 3,
              isRandSize: true,
              isRandomColor: true,
              randColorList: [
                // Colors.red.withAlpha(210),
                Colors.white.withAlpha(210),
                // Colors.yellow.withAlpha(210),
                // Colors.green.withAlpha(210)
              ],
              awayAnimationCurve: Curves.decelerate,
              enableHover: false,
              hoverColor: Colors.white,
              hoverRadius: 90,
              connectDots: true, //not recommended
            ),
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width / 3,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: DefaultTextStyle(
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 9.5,
                            fontFamily: 'Agne',
                            fontWeight: FontWeight.bold,
                          ),
                          child: AnimatedTextKit(
                            animatedTexts: [
                              TypewriterAnimatedText(
                                  'Welcome to Unified System Access'),
                              TypewriterAnimatedText('We are your Guardian.'),
                              TypewriterAnimatedText(
                                  'We help you monitor all your accounts.'),
                              TypewriterAnimatedText(
                                  'Your account, Your Control!'),
                            ],
                            onTap: () {
                              print("Tap Event");
                            },
                          ),
                        ),
                      ),
                      // Text(
                      //   'Welcome',
                      //   style: TextStyle(
                      //     color: Colors.white,
                      //     fontSize: 40,
                      //     fontWeight: FontWeight.w400,
                      //   ),
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(vertical: 37),
                      //   child: Text(
                      //     "To",
                      //     style: TextStyle(
                      //       color: Colors.white,
                      //       fontSize: 30,
                      //       fontWeight: FontWeight.w400,
                      //     ),
                      //   ),
                      // ),
                      // Text(
                      //   'Unified System Access',
                      //   style: TextStyle(
                      //     color: Colors.white,
                      //     fontSize: MediaQuery.of(context).size.width / 10,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width / 2,
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: SlideAction(
                      text: "Swipe to proceed > > >",
                      textStyle: TextStyle(fontSize: 20, color: Colors.white
                          //  HexColor('#68451d'),
                          ),
                      //sliderButtonIconPadding: 8,
                      key: _key,
                      // height: 95,
                      height: 85,
                      // outerColor: HexColor('#d8c8ad').withOpacity(0.7),
                      outerColor: HexColor("#083473"),
                      sliderButtonIconSize: 38,
                      //animationDuration: Duration(seconds: 1),
                      reversed: false,
                      onSubmit: () {
                        Future.delayed(
                          Duration(seconds: 1),
                          () => Navigator.pushNamedAndRemoveUntil(context,
                              '/landingPage/VerifyNumber', (route) => false),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
