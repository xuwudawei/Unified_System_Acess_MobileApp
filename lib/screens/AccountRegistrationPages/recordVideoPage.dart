import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class RecordVideoPage extends StatefulWidget {
  const RecordVideoPage({Key? key}) : super(key: key);

  @override
  _RecordVideoPageState createState() => _RecordVideoPageState();
}

class _RecordVideoPageState extends State<RecordVideoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios_new),
        ),
        actions: [
          //Make sure you modify the code here to make changes to the video recording then remove alml routes to home page next
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/home'),
            child: Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
