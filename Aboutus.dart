import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ColorClass.dart'; // Assuming this contains your custom colors
import 'Login.dart'; // Import the Login screen

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignColor.yelloColors, // Use the same background color
      body: Column(
        children: [
          // First Row with CircleAvatars and Text
          Row(
            children: [
                 Expanded(
                child: Center(
                  child: Text(
                    'About Us',
                    style: GoogleFonts.lobster(
                      fontSize: 35, // Font size
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
                ),
              ),

              // Suffix CircleAvatar wrapped with InkWell
            ],
          ),

          // Divider with an image
          Row(
            children: [
              Expanded(
                child: Container(
                  child: Image.asset(
                    'assets/BottomRect.jpg',
                    fit: BoxFit.cover,
                  ),
                  height: 10,
                ),
              ),
            ],
          ),

          // About Us Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Pizza Shop Image
                  Container(
                    margin: EdgeInsets.only(bottom: 20.0),
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/pizza1.jpg'), // Use a pizza image
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // About Us Text
                  Text(
                    'Welcome to Pizza Virtual Shop!',
                    style: GoogleFonts.lobster(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.red[800],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'We are passionate about delivering the most delicious and authentic pizzas to your doorstep. '
                        'Our pizzas are made with the freshest ingredients and baked to perfection. '
                        'Whether you\'re craving a classic Margherita or a spicy Pepperoni, we\'ve got you covered!',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[800],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Our Mission',
                    style: GoogleFonts.lobster(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.red[800],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'To bring joy to your life through the perfect slice of pizza.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[800],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Contact Us',
                    style: GoogleFonts.lobster(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.red[800],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Email: info@pizzavirtualshop.com\nPhone: +123 456 7890',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[800],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}