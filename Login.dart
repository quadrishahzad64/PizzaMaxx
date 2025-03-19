import 'package:flutter/material.dart';
import 'TextField.dart';
import 'homePage.dart';
import 'pizza.dart'; // Import the PizzaScreen
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts
import 'ColorClass.dart'; // Import your custom color class

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Predefined list of valid users
  final List<Map<String, String>> validUsers = [
    {'username': 'Shahzad', 'password': '12345'},
    {'username': 'Arif', 'password': '12345'},
    {'username': 'Taber', 'password': '12345'},
  ];

  String errorMessage = '';

  void login() {
    if (formKey.currentState!.validate()) {
      String username = usernameController.text;
      String password = passwordController.text;

      bool isValidUser = validUsers.any((user) =>
      user['username'] == username && user['password'] == password);

      if (isValidUser) {
        setState(() {
          errorMessage = '';
        });

        // Navigate to PizzaScreen and pass the username
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AppHomePage(), // Replace with the actual username
          ),
        );
      } else {
        setState(() {
          errorMessage = 'Invalid username or password';
        });
      }
    }
  }

  void signUp() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyTextfield(),
      ),
    );
  }

  void returnHome() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignColor.yelloColors, // Use the same background color as pizza.dart
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Make AppBar transparent
        elevation: 0, // Remove shadow
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.red[800]), // Back button with red color
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome Back!',
                style: GoogleFonts.lobster(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.red[800],
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.5),
                      offset: Offset(2, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: TextStyle(color: Colors.red[800]), // Label color
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red[800]!), // Border color
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red[800]!), // Enabled border color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red[800]!), // Focused border color
                  ),
                  prefixIcon: Icon(Icons.person, color: Colors.red[800]), // Icon color
                ),
                style: TextStyle(color: Colors.red[800]), // Text color
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.red[800]), // Label color
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red[800]!), // Border color
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red[800]!), // Enabled border color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red[800]!), // Focused border color
                  ),
                  prefixIcon: Icon(Icons.lock, color: Colors.red[800]), // Icon color
                ),
                style: TextStyle(color: Colors.red[800]), // Text color
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              if (errorMessage.isNotEmpty)
                Text(
                  errorMessage,
                  style: TextStyle(color: Colors.red),
                ),

              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: login,
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 16, // Reduced font size
                        fontWeight: FontWeight.bold,
                        color: DesignColor.yelloColors, // Text color
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Reduced padding
                      backgroundColor: Colors.red[800], // Button background color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Rounded corners
                      ),
                      minimumSize: Size(100, 40), // Set minimum width and height
                    ),
                  ),
                  SizedBox(width: 10), // Reduced spacing between buttons
                  ElevatedButton(
                    onPressed: signUp,
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 16, // Reduced font size
                        fontWeight: FontWeight.bold,
                        color: DesignColor.yelloColors, // Text color
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Reduced padding
                      backgroundColor: Colors.red[800], // Button background color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Rounded corners
                      ),
                      minimumSize: Size(100, 40), // Set minimum width and height
                    ),
                  ),
                  SizedBox(width: 10), // Reduced spacing between buttons
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}