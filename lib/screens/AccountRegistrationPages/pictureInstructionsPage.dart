import 'package:flutter/material.dart';

class PictureInstructionsPage extends StatefulWidget {
  const PictureInstructionsPage({Key? key}) : super(key: key);

  @override
  _PictureInstructionsPageState createState() =>
      _PictureInstructionsPageState();
}

class _PictureInstructionsPageState extends State<PictureInstructionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios_new),
        ),
        // actions: [
        //   GestureDetector(
        //     onTap: () {},
        //     child: Icon(Icons.arrow_forward_ios),
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "Face ID Registration",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Strictly follow the Instructions below:",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              Text(
                  "\n1. Record a 5 seconds video of yourself with your face in front of your mobile front camera.\n\n2. Move your head in all directions to capture every single angle of your face.\n\n3. Make sure your face is clear and visible in the camera.",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  )),
              Image.asset(
                "assets/images/instructions.png",
                height: MediaQuery.of(context).size.height * 0.4,
              ),
              MaterialButton(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.green,
                child: Text(
                  "I have read and understood the instructions.\nProceed to the next step",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/cameraScreenPage');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
