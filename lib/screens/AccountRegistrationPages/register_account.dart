import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';

class RegisterAccountPage extends StatefulWidget {
  const RegisterAccountPage({Key? key}) : super(key: key);

  @override
  _RegisterAccountPageState createState() => _RegisterAccountPageState();
}

class _RegisterAccountPageState extends State<RegisterAccountPage> {
  final zipCodeController = TextEditingController();
  final streetAddressController = TextEditingController();
  final apartmentController = TextEditingController();

  String? countryValue;
  String? stateValue;
  String? cityValue;
  String? streetAdress;
  String? apartment;
  String? zipCode;
  String? streetAddress;
  bool? completedEachField;
  bool isZipValid(var zip) {
    if (RegExp(r"^[a-z0-9][a-z0-9\- ]{0,10}[a-z0-9]$", caseSensitive: false)
        .hasMatch(zip)) {
      completedEachField = true;
      return true;
    } else {
      completedEachField = false;
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,

        centerTitle: false,

        // leading: GestureDetector(
        //   child: Icon(Icons.arrow_back_ios_new),
        //   onTap: () => Navigator.pop(context),
        // ),
        actions: [
          IconButton(
            onPressed: () {
              if (completedEachField == true &&
                  countryValue != null &&
                  streetAddress != null &&
                  apartment != null &&
                  zipCode != null) {
                Navigator.pushNamed(context, '/Country/DocumentScanning');
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('You left some fields empty!'),
                      content: Text('Please complete all fields'),
                      actions: [
                        FlatButton(
                          child: Text('Ok'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            },
            icon: Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "Country of Residence",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SelectState(
                  style: TextStyle(color: Colors.grey, fontSize: 23),
                  onCountryChanged: (value) {
                    setState(() {
                      countryValue = value;
                    });
                  },
                  onStateChanged: (value) {
                    setState(() {
                      stateValue = value;
                    });
                  },
                  onCityChanged: (value) {
                    setState(() {
                      cityValue = value;
                    });
                  },
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: TextStyle(color: Colors.white, fontSize: 23),
                  decoration: InputDecoration(
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    isDense: true,
                    border: OutlineInputBorder(),
                    labelText: 'Zip code',
                    labelStyle: TextStyle(color: Colors.grey),
                    hintText: 'Zip Code',
                    suffixText: 'Required',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  validator: (zipcode) =>
                      isZipValid(zipcode) ? null : 'Invalid Zip Code',
                  onChanged: (value) {
                    zipCode = value;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == "") {
                      completedEachField = false;
                      return 'Please enter your street address';
                    } else {
                      completedEachField = true;
                      return null;
                    }
                  },
                  style: TextStyle(color: Colors.white, fontSize: 23),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    isDense: true,
                    border: OutlineInputBorder(),
                    labelText: 'Street Address',
                    labelStyle: TextStyle(color: Colors.grey),
                    hintText: 'Street Address',
                    suffixText: 'Required',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  onChanged: (value) {
                    streetAddress = value;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == "") {
                      completedEachField = false;
                      return 'Please enter your apartment/Suite details';
                    } else {
                      completedEachField = true;
                      return null;
                    }
                  },
                  style: TextStyle(color: Colors.white, fontSize: 23),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    isDense: true,
                    border: OutlineInputBorder(),
                    labelText: 'Apartment/Suite',
                    labelStyle: TextStyle(color: Colors.grey),
                    hintText: 'Apartment/Suite',
                    suffixText: 'Required',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  onChanged: (value) {
                    apartment = value;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
