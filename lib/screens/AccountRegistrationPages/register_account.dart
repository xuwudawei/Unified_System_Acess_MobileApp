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
            onPressed: () =>
                Navigator.pushNamed(context, '/Country/DocumentScanning'),
            icon: Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
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
              TextField(
                style: TextStyle(color: Colors.white, fontSize: 23),
                decoration: InputDecoration(
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
                onChanged: (value) {
                  zipCode = value;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
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
              TextField(
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
    );
  }
}
