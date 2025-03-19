import 'package:flutter/material.dart';
import 'dart:convert'; // For JSON encoding/decoding
import 'dart:io'; // For file operations
import 'package:path_provider/path_provider.dart';

import 'ColorClass.dart'; // For accessing the file system

class MyTextfield extends StatefulWidget {
  const MyTextfield({super.key});

  @override
  State<MyTextfield> createState() => _MyTextfieldState();
}

class _MyTextfieldState extends State<MyTextfield> {
  var useremail = TextEditingController();
  var userPass = TextEditingController();
  var userPassCon = TextEditingController();
  var userName = TextEditingController();
  var userPhone = TextEditingController();
  var useraddress = TextEditingController();
  var userDob = TextEditingController();

  // Track password visibility
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  final formKey = GlobalKey<FormState>(); // Add a form key

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        userDob.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  void _validateFields() async {
    if (formKey.currentState!.validate()) {
      // If all fields are valid, save the data to a JSON file
      Map<String, dynamic> userData = {
        "email": useremail.text.trim(),
        "password": userPass.text.trim(),
        "name": userName.text.trim(),
        "phone": userPhone.text.trim(),
        "address": useraddress.text.trim(),
        "dob": userDob.text.trim(),
      };

      await _saveUserDataToFile(userData);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User created successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      // If validation fails, show a generic error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields correctly.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _saveUserDataToFile(Map<String, dynamic> userData) async {
    try {
      // Convert the user data to a JSON string
      String jsonString = jsonEncode(userData);

      // Get the directory for storing the file
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/user_data.json');

      // Write the JSON string to the file
      await file.writeAsString(jsonString);

      print('User data saved to: ${file.path}');
    } catch (e) {
      print('Error saving user data: $e');
    }
  }

  void _clearFields() {
    useremail.clear();
    userPass.clear();
    userPassCon.clear();
    userName.clear();
    userPhone.clear();
    useraddress.clear();
    userDob.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('All fields have been cleared.'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void returnHome() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignColor.yelloColors, // Use the same background color as login.dart
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey, // Add the form key
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Email TextField
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: useremail,
                    decoration: InputDecoration(
                      hintText: 'Enter Email',
                      hintStyle: TextStyle(color: Colors.red[800]), // Hint text color
                      suffixIcon: Icon(Icons.email, color: Colors.red[800]), // Icon color
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: BorderSide(color: Colors.red[800]!), // Border color
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: BorderSide(color: Colors.red[800]!), // Focused border color
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8), // Background color
                    ),
                    style: TextStyle(color: Colors.red[800]), // Text color
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email address';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 5),

                  // Password TextField
                  TextFormField(
                    obscureText: !_isPasswordVisible,
                    controller: userPass,
                    decoration: InputDecoration(
                      hintText: 'Enter Password',
                      hintStyle: TextStyle(color: Colors.red[800]), // Hint text color
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                          color: Colors.red[800], // Icon color
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: BorderSide(color: Colors.red[800]!), // Border color
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: BorderSide(color: Colors.red[800]!), // Focused border color
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8), // Background color
                    ),
                    style: TextStyle(color: Colors.red[800]), // Text color
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 5),

                  // Confirm Password TextField
                  TextFormField(
                    obscureText: !_isConfirmPasswordVisible,
                    controller: userPassCon,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      hintStyle: TextStyle(color: Colors.red[800]), // Hint text color
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                          color: Colors.red[800], // Icon color
                        ),
                        onPressed: () {
                          setState(() {
                            _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                          });
                        },
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: BorderSide(color: Colors.red[800]!), // Border color
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: BorderSide(color: Colors.red[800]!), // Focused border color
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8), // Background color
                    ),
                    style: TextStyle(color: Colors.red[800]), // Text color
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != userPass.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 5),

                  // User Name TextField
                  TextFormField(
                    keyboardType: TextInputType.name,
                    controller: userName,
                    decoration: InputDecoration(
                      hintText: 'Enter User Name',
                      hintStyle: TextStyle(color: Colors.red[800]), // Hint text color
                      suffixIcon: Icon(Icons.person, color: Colors.red[800]), // Icon color
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: BorderSide(color: Colors.red[800]!), // Border color
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: BorderSide(color: Colors.red[800]!), // Focused border color
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8), // Background color
                    ),
                    style: TextStyle(color: Colors.red[800]), // Text color
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 5),

                  // Phone Number TextField
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    controller: userPhone,
                    decoration: InputDecoration(
                      hintText: 'Enter Phone e.g 0000-0000000',
                      hintStyle: TextStyle(color: Colors.red[800]), // Hint text color
                      suffixIcon: Icon(Icons.phone, color: Colors.red[800]), // Icon color
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: BorderSide(color: Colors.red[800]!), // Border color
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: BorderSide(color: Colors.red[800]!), // Focused border color
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8), // Background color
                    ),
                    style: TextStyle(color: Colors.red[800]), // Text color
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 5),

                  // Date of Birth TextField
                  TextFormField(
                    controller: userDob,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: 'Select Date of Birth',
                      hintStyle: TextStyle(color: Colors.red[800]), // Hint text color
                      suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_today, color: Colors.red[800]), // Icon color
                        onPressed: () => _selectDate(context),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: BorderSide(color: Colors.red[800]!), // Border color
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: BorderSide(color: Colors.red[800]!), // Focused border color
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8), // Background color
                    ),
                    style: TextStyle(color: Colors.red[800]), // Text color
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your date of birth';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 5),

                  // Address TextField
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    controller: useraddress,
                    maxLines: 3,
                    maxLength: 100,
                    decoration: InputDecoration(
                      hintText: 'Enter Address',
                      hintStyle: TextStyle(color: Colors.red[800]), // Hint text color
                      suffixIcon: Icon(Icons.home, color: Colors.red[800]), // Icon color
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: BorderSide(color: Colors.red[800]!), // Border color
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: BorderSide(color: Colors.red[800]!), // Focused border color
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8), // Background color
                    ),
                    style: TextStyle(color: Colors.red[800]), // Text color
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 5),

                  // Row for Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 1,
                        child: ElevatedButton(
                          onPressed: _clearFields,
                          child: Text(
                            'Clear',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: DesignColor.yelloColors, // Text color
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                            backgroundColor: Colors.red[800], // Button background color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), // Rounded corners
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      Flexible(
                        flex: 1,
                        child: ElevatedButton(
                          onPressed: _validateFields,
                          child: Text(
                            'Create',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: DesignColor.yelloColors, // Text color
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                            backgroundColor: Colors.red[800], // Button background color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), // Rounded corners
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      Flexible(
                        flex: 1,
                        child: ElevatedButton(
                          onPressed: returnHome,
                          child: Text(
                            'Home',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: DesignColor.yelloColors, // Text color
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                            backgroundColor: Colors.red[800], // Button background color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), // Rounded corners
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}