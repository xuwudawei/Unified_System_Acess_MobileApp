import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart' as vd;
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:usa_app/colors.dart';

class PersonalInformationPage extends StatefulWidget {
  const PersonalInformationPage({Key? key}) : super(key: key);

  @override
  _PersonalInformationPageState createState() =>
      _PersonalInformationPageState();
}

class _PersonalInformationPageState extends State<PersonalInformationPage> {
  String? firstName;
  String? middleName;
  String? lastName;
  String? email;
  String? validEmail;
  String? dateOfBirth;
  String? nationality;
  String? gender;
  final formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  TextEditingController _datePicked = TextEditingController();
  List<String> _genders = [
    'Select your gender',
    'Male',
    'Female',
    'Transgender'
  ];
  String _selectedGender = "";
  String dropdownvalue = 'Select your gender';
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1930, 8),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _datePicked.text =
            DateFormat('dd-MM-yyyy').format(selectedDate).toString();
      });
  }

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
          GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(
                '/Country/DocumentScanning/PersonalInfo/VideoRecordingInstructions'),
            child: Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
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
                    "Personal Information",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                TextField(
                  style: TextStyle(color: Colors.white, fontSize: 23),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    isDense: true,
                    border: OutlineInputBorder(),
                    labelText: 'First Name',
                    labelStyle: TextStyle(color: Colors.grey),
                    hintText: 'First Name',
                    suffixText: 'Required',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  onChanged: (value) {
                    firstName = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  style: TextStyle(color: Colors.white, fontSize: 23),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    isDense: true,
                    border: OutlineInputBorder(),
                    labelText: 'Middle Name',
                    labelStyle: TextStyle(color: Colors.grey),
                    hintText: 'Middle Name',
                    suffixText: 'Optional',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  onChanged: (value) {
                    middleName = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  style: TextStyle(color: Colors.white, fontSize: 23),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    isDense: true,
                    border: OutlineInputBorder(),
                    labelText: 'Last Name',
                    labelStyle: TextStyle(color: Colors.grey),
                    hintText: 'Last Name',
                    suffixText: 'Required',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  onChanged: (value) {
                    lastName = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
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
                        validEmail = null;
                      });
                    } else {
                      setState(() {
                        validEmail = 'Please enter a valid email';
                      });
                    }
                  },
                  onSaved: (emails) {
                    this.email = emails;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _datePicked,
                  style: TextStyle(color: Colors.white, fontSize: 23),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    isDense: true,
                    border: OutlineInputBorder(),
                    labelText: 'Date of Birth',
                    labelStyle: TextStyle(color: Colors.grey),
                    hintText: 'Date of Birth',
                    suffixText: 'Required',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  onTap: () => _selectDate(context),
                ),
                SizedBox(
                  height: 10,
                ),
                DropdownButton(
                  dropdownColor: HexColor(lightDark),
                  hint: Text(
                    "Select your gender",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                    ),
                  ),
                  value: dropdownvalue,
                  items: _genders.map((gender) {
                    return DropdownMenuItem(
                      child: Text(
                        gender,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                        ),
                      ),
                      value: gender,
                    );
                  }).toList(),
                  isExpanded: true,
                  onChanged: (newChoice) {
                    setState(
                      () {
                        dropdownvalue = newChoice.toString();
                      },
                    );
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
