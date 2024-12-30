import 'package:flutter/material.dart';

class UserFormPage extends StatefulWidget {
  @override
  _UserFormPageState createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  String? nameError;
  String? emailError;
  String? phoneError;
  String? genderError;
  String? countryError;
  String? stateError;
  String? cityError;

  String? selectedGender;

  void validateField(String value, String field) {
    setState(() {
      switch (field) {
        case 'name':
          if (value.isEmpty) {
            nameError = 'Please enter your name';
          } else if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
            nameError = 'Name should contain only letters';
          } else {
            nameError = null;
          }
          break;
        case 'email':
          if (value.isEmpty) {
            emailError = 'Please enter your email';
          } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
            emailError = 'Please enter a valid email';
          } else {
            emailError = null;
          }
          break;
        case 'phone':
          if (value.isEmpty) {
            phoneError = 'Please enter your phone number';
          } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
            phoneError = 'Please enter a valid 10-digit phone number';
          } else {
            phoneError = null;
          }
          break;
        case 'country':
          countryError = value.isEmpty ? 'Please enter your country' : null;
          break;
        case 'state':
          stateError = value.isEmpty ? 'Please enter your state' : null;
          break;
        case 'city':
          cityError = value.isEmpty ? 'Please enter your city' : null;
          break;
      }
    });
  }

  void validateGender() {
    setState(() {
      genderError = selectedGender == null ? 'Please select your gender' : null;
    });
  }

  void validateAllFields() {
    validateField(nameController.text, 'name');
    validateField(emailController.text, 'email');
    validateField(phoneController.text, 'phone');
    validateField(countryController.text, 'country');
    validateField(stateController.text, 'state');
    validateField(cityController.text, 'city');
    validateGender();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details Form', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.orange,
        elevation: 5,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(color: Colors.orange),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                  errorText: nameError,
                  errorStyle: TextStyle(color: Colors.red), // Red error text
                ),
                onChanged: (value) => validateField(value, 'name'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.orange),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                  errorText: emailError,
                  errorStyle: TextStyle(color: Colors.red), // Red error text
                ),
                onChanged: (value) => validateField(value, 'email'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone',
                  labelStyle: TextStyle(color: Colors.orange),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                  errorText: phoneError,
                  errorStyle: TextStyle(color: Colors.red), // Red error text
                ),
                keyboardType: TextInputType.phone,
                onChanged: (value) => validateField(value, 'phone'),
              ),
              SizedBox(height: 16),
              Text('Gender', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.orange)),
              Column(
                children: [
                  RadioListTile<String>(
                    title: Text('Male'),
                    value: 'Male',
                    groupValue: selectedGender,
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value;
                      });
                      validateGender();
                    },
                  ),
                  RadioListTile<String>(
                    title: Text('Female'),
                    value: 'Female',
                    groupValue: selectedGender,
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value;
                      });
                      validateGender();
                    },
                  ),
                  RadioListTile<String>(
                    title: Text('Other'),
                    value: 'Other',
                    groupValue: selectedGender,
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value;
                      });
                      validateGender();
                    },
                  ),
                ],
              ),
              if (genderError != null)
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    genderError!,
                    style: TextStyle(color: Colors.red, fontSize: 12), // Red error text
                  ),
                ),
              SizedBox(height: 16),
              TextFormField(
                controller: countryController,
                decoration: InputDecoration(
                  labelText: 'Country',
                  labelStyle: TextStyle(color: Colors.orange),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                  errorText: countryError,
                  errorStyle: TextStyle(color: Colors.red), // Red error text
                ),
                onChanged: (value) => validateField(value, 'country'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: stateController,
                decoration: InputDecoration(
                  labelText: 'State',
                  labelStyle: TextStyle(color: Colors.orange),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                  errorText: stateError,
                  errorStyle: TextStyle(color: Colors.red), // Red error text
                ),
                onChanged: (value) => validateField(value, 'state'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: cityController,
                decoration: InputDecoration(
                  labelText: 'City',
                  labelStyle: TextStyle(color: Colors.orange),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                  errorText: cityError,
                  errorStyle: TextStyle(color: Colors.red), // Red error text
                ),
                onChanged: (value) => validateField(value, 'city'),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  validateAllFields();
                  if (_formKey.currentState!.validate() &&
                      nameError == null &&
                      emailError == null &&
                      phoneError == null &&
                      genderError == null &&
                      countryError == null &&
                      stateError == null &&
                      cityError == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Form submitted successfully')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange, // Button color
                  padding: EdgeInsets.symmetric(vertical: 15), // Button padding
                  textStyle: TextStyle(fontSize: 18), // Text style
                ),
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
