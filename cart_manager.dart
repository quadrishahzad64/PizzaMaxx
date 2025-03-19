import 'selected_pizza.dart';
import 'SelectedIceCream.dart';

class CartManager {
  // Singleton pattern to ensure only one instance of CartManager
  static final CartManager _instance = CartManager._internal();
  factory CartManager() => _instance;
  CartManager._internal();

  // Lists to store selected pizzas and ice creams
  List<SelectedPizza> selectedPizzas = [];
  List<SelectedIceCream> selectedIceCreams = [];

  // Add a pizza to the cart
  void addPizza(SelectedPizza pizza) {
    selectedPizzas.add(pizza);
  }

  // Add an ice cream to the cart
  void addIceCream(SelectedIceCream iceCream) {
    selectedIceCreams.add(iceCream);
  }

  // Clear the cart
  void clearCart() {
    selectedPizzas.clear();
    selectedIceCreams.clear();
  }

  // Get the total price of all items in the cart
  double getTotalPrice() {
    double total = 0;
    for (var pizza in selectedPizzas) {
      for (var price in pizza.prices) {
        total += double.parse(price);
      }
    }
    for (var iceCream in selectedIceCreams) {
      for (var price in iceCream.prices) {
        total += double.parse(price);
      }
    }
    return total;
  }
}
