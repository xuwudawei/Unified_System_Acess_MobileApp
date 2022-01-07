import 'package:flutter/material.dart';

class ApprovalPendingPage extends StatefulWidget {
  const ApprovalPendingPage({Key? key}) : super(key: key);

  @override
  _ApprovalPendingPageState createState() => _ApprovalPendingPageState();
}

class _ApprovalPendingPageState extends State<ApprovalPendingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                    top: 80, left: 10, right: 10, bottom: 40),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "Pending Approval",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Image.asset(
                'assets/images/pendingApprovalimage.png',
                color: Colors.white,
                height: MediaQuery.of(context).size.width / 2,
              ),
              Text(
                "Your Account is currently in approval process. Please wait for the approval to be completed.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 5.5),
                child: Text(
                  "If encountered any issue, kindly contact us using the email below.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                "admin@usa.com",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
