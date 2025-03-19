import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ColorClass.dart';
import 'bill.dart'; // Import the Bill screen
import 'cart_manager.dart';
import 'SelectedIceCream.dart'; // Import the SelectedIceCream class
import 'Login.dart'; // Import the Login screen

class IceCream extends StatefulWidget {
  const IceCream({super.key});

  @override
  _IceCreamState createState() => _IceCreamState();
}

class _IceCreamState extends State<IceCream> {
  // Example list of items for the ListView.builder
  final List<Map<String, String>> iceItems = [
    {'Icecream': 'Vanilla', 'Cone': '300', 'Scoop': '150', 'Bar': '200'},
    {'Icecream': 'Mango', 'Cone': '300', 'Scoop': '150', 'Bar': '200'},
    {'Icecream': 'Chocolate', 'Cone': '300', 'Scoop': '150', 'Bar': '200'},
    {'Icecream': 'Strawberry', 'Cone': '300', 'Scoop': '150', 'Bar': '200'},
    {'Icecream': 'Pistachio', 'Cone': '300', 'Scoop': '150', 'Bar': '200'},
  ];
  final List<String> iceImage = [
    'assets/icecream1.jpg',
    'assets/icecream2.jpg',
    'assets/icecream3.jpg',
    'assets/icecream4.jpg',
    'assets/icecream5.jpg',
  ];

  // List to track the selected flavour for each ice cream
  List<String> selectedFlavourList = [];

  // List to track the checked state of each size for every ice cream
  List<Map<String, bool>> sizeCheckboxState = [];

  // List to store selected ice creams
  List<SelectedIceCream> selectedIceCreams = [];

  @override
  void initState() {
    super.initState();
    // Initialize the selected flavour list with 'Single Cone' as default
    selectedFlavourList = List<String>.filled(iceItems.length, 'Single Cone');
    // Initialize the size checkbox state list
    sizeCheckboxState = List.generate(iceItems.length, (index) => {
      'Cone': false,
      'Scoop': false,
      'Bar': false,
    });
  }

  // Method to reset checkbox states
  void _resetCheckboxStates() {
    setState(() {
      for (var state in sizeCheckboxState) {
        state['Cone'] = false;
        state['Scoop'] = false;
        state['Bar'] = false;
      }
    });
  }

  void _addSelectedIceCreams() {
    selectedIceCreams.clear(); // Clear previous selections
    for (int i = 0; i < iceItems.length; i++) {
      final iceCream = iceItems[i];
      final sizes = <String>[]; // Explicitly specify the type as List<String>
      final prices = <String>[]; // Explicitly specify the type as List<String>

      if (sizeCheckboxState[i]['Cone']!) {
        sizes.add('Cone');
        prices.add(iceCream['Cone']!);
      }
      if (sizeCheckboxState[i]['Scoop']!) {
        sizes.add('Scoop');
        prices.add(iceCream['Scoop']!);
      }
      if (sizeCheckboxState[i]['Bar']!) {
        sizes.add('Bar');
        prices.add(iceCream['Bar']!);
      }

      if (sizes.isNotEmpty) {
        selectedIceCreams.add(SelectedIceCream(
          name: iceCream['Icecream']!,
          flavour: selectedFlavourList[i],
          sizes: sizes,
          prices: prices, // Now this is a List<String>
        ));
      }
    }
  }

  void _navigateToBill(BuildContext context) {
    _addSelectedIceCreams(); // Collect selected ice creams
    if (selectedIceCreams.isNotEmpty) {
      // Add selected ice creams to the cart
      final cartManager = CartManager();
      cartManager.selectedIceCreams.addAll(selectedIceCreams);

      // Navigate to the Bill screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Bill(),
        ),
      ).then((_) {
        // Reset checkbox states after returning from the Bill screen
        _resetCheckboxStates();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select at least one ice cream!')),
      );
    }
  }

  void _navigateToLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignColor.yelloColors,
      body: Column(
        children: [
          // First Row with CircleAvatars and Text
          Row(
            children: [
              InkWell(
                onTap: () => _navigateToBill(context),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20, // Radius of the circle
                        backgroundColor: Colors.orange[800], // Customize the color
                        child: Icon(Icons.shopping_cart, color: DesignColor.yelloColors, size: 24),
                      ),
                      SizedBox(width: 8), // Add spacing between icon and text
                      Text(
                        'SHOP', // Text label
                        style: TextStyle(
                          color: Colors.orange[800], // Text color
                          fontSize: 20, // Text size
                          fontWeight: FontWeight.bold, // Bold text
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Expanded widget to take available space
              Expanded(
                child: Center(
                  child: Text(
                    'ICE-CREAME',
                    style: GoogleFonts.lobster( // Use a Google Font (e.g., Lobster)
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

            ],
          ),

          // Second Row with Image.asset
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

          // Add ListView.builder inside a Container
          Expanded(
            child: Container(
              margin: EdgeInsets.all(15.0), // Optional: Add margin
              child: ListView.builder(
                itemCount: iceItems.length,
                itemBuilder: (context, index) {
                  // Access the current ice cream item
                  final iceCream = iceItems[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text(
                        iceCream['Icecream']!, // Ice cream name
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Dropdown for flavour selection
                          DropdownButton<String>(
                            value: selectedFlavourList[index],
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedFlavourList[index] = newValue!; // Update the selected flavour
                              });
                            },
                            items: <String>['Single Cone', 'Double Cone']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          // Checkbox for Cone
                          Row(
                            children: [
                              Checkbox(
                                value: sizeCheckboxState[index]['Cone'],
                                onChanged: (bool? value) {
                                  setState(() {
                                    sizeCheckboxState[index]['Cone'] = value!; // Update the checkbox state
                                  });
                                },
                              ),
                              Text(
                                'Cone: ${iceCream['Cone']!}', // Cone price
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          // Checkbox for Scoop
                          Row(
                            children: [
                              Checkbox(
                                value: sizeCheckboxState[index]['Scoop'],
                                onChanged: (bool? value) {
                                  setState(() {
                                    sizeCheckboxState[index]['Scoop'] = value!; // Update the checkbox state
                                  });
                                },
                              ),
                              Text(
                                'Scoop: ${iceCream['Scoop']!}', // Scoop price
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          // Checkbox for Bar
                          Row(
                            children: [
                              Checkbox(
                                value: sizeCheckboxState[index]['Bar'],
                                onChanged: (bool? value) {
                                  setState(() {
                                    sizeCheckboxState[index]['Bar'] = value!; // Update the checkbox state
                                  });
                                },
                              ),
                              Text(
                                'Bar: ${iceCream['Bar']!}', // Bar price
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // Move the image to the right side and make it larger
                      trailing: Container(
                        width: 200, // Adjust the width
                        height: 200, // Adjust the height
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(iceImage[index]),
                          ),
                        ),
                      ),
                      onTap: () {
                        // Handle item tap
                        print('${iceCream['Icecream']} tapped');
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ], // Column
      ),
    );
  }
}