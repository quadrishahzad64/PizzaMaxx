import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ColorClass.dart';
import 'bill.dart'; // Import the Bill screen
import 'cart_manager.dart';
import 'selected_pizza.dart'; // Import the SelectedPizza class
import 'Login.dart'; // Import the Login screen

class Pizza extends StatefulWidget {

  Pizza({super.key});

  @override
  _PizzaState createState() => _PizzaState();
}

class _PizzaState extends State<Pizza> {
  // Example list of items for the ListView.builder
  final List<Map<String, String>> pizzaItems = [
    {'Pizza': 'Margherita Pizza', 'Large': '900', 'Medium': '500', 'Small': '250'},
    {'Pizza': 'Pepperoni Pizza', 'Large': '900', 'Medium': '500', 'Small': '250'},
    {'Pizza': 'BBQ Chicken Pizza', 'Large': '900', 'Medium': '500', 'Small': '250'},
    {'Pizza': 'Veggie Pizza', 'Large': '900', 'Medium': '500', 'Small': '250'},
    {'Pizza': 'Hawaiian Pizza', 'Large': '900', 'Medium': '500', 'Small': '250'},
  ];
  final List<String> pizzaImage = [
    'assets/pizza1.jpg',
    'assets/pizza2.jpg',
    'assets/pizza3.jpg',
    'assets/pizza4.jpg',
    'assets/pizza5.jpg',
  ];

  // List to track the selected flavour for each pizza
  List<String> selectedFlavourList = [];

  // List to track the checked state of each size for every pizza
  List<Map<String, bool>> sizeCheckboxState = [];

  // List to store selected pizzas
  List<SelectedPizza> selectedPizzas = [];

  @override
  void initState() {
    super.initState();
    // Initialize the selected flavour list with 'Spicy' as default
    selectedFlavourList = List<String>.filled(pizzaItems.length, 'Spicy');
    // Initialize the size checkbox state list
    sizeCheckboxState = List.generate(pizzaItems.length, (index) => {
      'Large': false,
      'Medium': false,
      'Small': false,
    });
  }

  // Method to reset checkbox states
  void _resetCheckboxStates() {
    setState(() {
      for (var state in sizeCheckboxState) {
        state['Large'] = false;
        state['Medium'] = false;
        state['Small'] = false;
      }
    });
  }

  void _addSelectedPizzas() {
    selectedPizzas.clear(); // Clear previous selections
    for (int i = 0; i < pizzaItems.length; i++) {
      final pizza = pizzaItems[i];
      final sizes = <String>[]; // Explicitly specify the type as List<String>
      final prices = <String>[]; // Explicitly specify the type as List<String>

      if (sizeCheckboxState[i]['Large']!) {
        sizes.add('Large');
        prices.add(pizza['Large']!);
      }
      if (sizeCheckboxState[i]['Medium']!) {
        sizes.add('Medium');
        prices.add(pizza['Medium']!);
      }
      if (sizeCheckboxState[i]['Small']!) {
        sizes.add('Small');
        prices.add(pizza['Small']!);
      }

      if (sizes.isNotEmpty) {
        selectedPizzas.add(SelectedPizza(
          name: pizza['Pizza']!,
          flavour: selectedFlavourList[i],
          sizes: sizes,
          prices: prices, // Now this is a List<String>
        ));
      }
    }
  }

  void _navigateToBill(BuildContext context) {
    _addSelectedPizzas(); // Collect selected pizzas
    if (selectedPizzas.isNotEmpty) {
      // Add selected pizzas to the cart
      final cartManager = CartManager();
      cartManager.selectedPizzas.addAll(selectedPizzas);

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
        SnackBar(content: Text('Please select at least one pizza!')),
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
                    'PIZZAS',
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
          Expanded( // Use Expanded to give ListView.builder a bounded height
            child: Container(
              margin: EdgeInsets.all(15.0), // Optional: Add margin
              child: ListView.builder(
                itemCount: pizzaItems.length,
                itemBuilder: (context, index) {
                  // Access the current pizza item
                  final pizza = pizzaItems[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text(
                        pizza['Pizza']!, // Pizza name
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
                            items: <String>['Spicy', 'Non-Spicy']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          // Checkbox for Large size
                          Row(
                            children: [
                              Checkbox(
                                value: sizeCheckboxState[index]['Large'],
                                onChanged: (bool? value) {
                                  setState(() {
                                    sizeCheckboxState[index]['Large'] = value!; // Update the checkbox state
                                  });
                                },
                              ),
                              Text(
                                'Large: ${pizza['Large']!}', // Large price
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          // Checkbox for Medium size
                          Row(
                            children: [
                              Checkbox(
                                value: sizeCheckboxState[index]['Medium'],
                                onChanged: (bool? value) {
                                  setState(() {
                                    sizeCheckboxState[index]['Medium'] = value!; // Update the checkbox state
                                  });
                                },
                              ),
                              Text(
                                'Medium: ${pizza['Medium']!}', // Medium price
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          // Checkbox for Small size
                          Row(
                            children: [
                              Checkbox(
                                value: sizeCheckboxState[index]['Small'],
                                onChanged: (bool? value) {
                                  setState(() {
                                    sizeCheckboxState[index]['Small'] = value!; // Update the checkbox state
                                  });
                                },
                              ),
                              Text(
                                'Small: ${pizza['Small']!}', // Small price
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
                            image: AssetImage(pizzaImage[index]),

                            //fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      onTap: () {
                        // Handle item tap
                        print('${pizza['Pizza']} tapped');
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ], // Column
      ),
      // Remove the bottomNavigationBar
    );
  }
}