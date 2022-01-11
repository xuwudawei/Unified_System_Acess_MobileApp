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
  String? documentIDNumber;
  String? dateOfBirth;

  String? gender;
  bool? completedEachField;
  final formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  TextEditingController _datePicked = TextEditingController();
  List<String> _genders = [
    'Select your gender',
    'Male',
    'Female',
    'Others',
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
        dateOfBirth = _datePicked.text;
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
          IconButton(
            onPressed: () {
              if (completedEachField == true &&
                  firstName != null &&
                  lastName != null &&
                  documentIDNumber != null &&
                  gender != null &&
                  dateOfBirth != null) {
                Navigator.of(context).pushNamed(
                    '/Country/DocumentScanning/PersonalInfo/faceCapturingInstructions');
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
            icon: Icon(
              Icons.arrow_forward_ios,
            ),
          )
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
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == "") {
                      completedEachField = false;
                      return 'Please enter your first name';
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
                TextFormField(
                  textInputAction: TextInputAction.next,
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
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == "") {
                      completedEachField = false;
                      return 'Please enter your last name';
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
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == "") {
                      completedEachField = false;
                      return 'Please enter your document ID number';
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
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    labelText: 'Document ID Number',
                    labelStyle: TextStyle(color: Colors.grey),
                    hintText: 'Document ID Number',
                    suffixText: 'Required',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  onChanged: (value) {
                    documentIDNumber = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  readOnly: true,
                  validator: (value) {
                    if (value == "") {
                      completedEachField = false;
                      return 'Please select your date of birth';
                    } else {
                      completedEachField = true;
                      return null;
                    }
                  },
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
                        gender = dropdownvalue;
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
