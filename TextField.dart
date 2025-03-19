import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts
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

  // Validation methods for each field
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!value.contains('@')) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm Password is required';
    }
    if (value != userPass.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (!RegExp(r'^\d{4}-\d{7}$').hasMatch(value)) {
      return 'Please enter a valid phone number (e.g., 0000-0000000)';
    }
    return null;
  }

  String? _validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Address is required';
    }
    return null;
  }

  void _validateFields() {
    // Validate each field individually
    final emailError = _validateEmail(useremail.text);
    final passwordError = _validatePassword(userPass.text);
    final confirmPasswordError = _validateConfirmPassword(userPassCon.text);
    final nameError = _validateName(userName.text);
    final phoneError = _validatePhone(userPhone.text);
    final addressError = _validateAddress(useraddress.text);

    // Show error messages for invalid fields
    if (emailError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(emailError),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (passwordError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(passwordError),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (confirmPasswordError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(confirmPasswordError),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (nameError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(nameError),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (phoneError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(phoneError),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (addressError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(addressError),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // If all fields are valid, show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('User created successfully!'),
        backgroundColor: Colors.green,
      ),
    );

    // You can add your logic here (e.g., save data or navigate to another screen)
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Add the title here with Google Fonts
                Text(
                  'Sign Up Screen',
                  style: GoogleFonts.lobster( // Use a Google Font (e.g., Lobster)
                    fontSize: 40, // Large font size
                    fontWeight: FontWeight.bold, // Bold text
                    color: Colors.red[800], // Text color
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.5), // Shadow color
                        offset: Offset(2, 2), // Shadow offset
                        blurRadius: 4, // Shadow blur radius
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20), // Add some spacing

                // Email TextField
                TextField(
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
                ),
                const SizedBox(height: 5),

                // Password TextField
                TextField(
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
                ),
                const SizedBox(height: 5),

                // Confirm Password TextField
                TextField(
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
                ),
                const SizedBox(height: 5),

                // User Name TextField
                TextField(
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
                ),
                const SizedBox(height: 5),

                // Phone Number TextField
                TextField(
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
                ),
                const SizedBox(height: 5),

                // Address TextField
                TextField(
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
                        onPressed: _validateFields, // Call the validation method
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
                          'Login',
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
    );
  }
}