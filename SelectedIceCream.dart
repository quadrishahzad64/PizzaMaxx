class SelectedIceCream {
  final String name; // Name of the ice cream (e.g., Vanilla, Mango)
  final String flavour; // Selected flavour (e.g., Single Cone, Double Cone)
  final List<String> sizes; // Selected sizes (e.g., Cone, Scoop, Bar)
  final List<String> prices; // Prices corresponding to the selected sizes

  // Constructor
  SelectedIceCream({
    required this.name,
    required this.flavour,
    required this.sizes,
    required this.prices,
  });

  // Optional: Override toString() for debugging
  @override
  String toString() {
    return 'SelectedIceCream{name: $name, flavour: $flavour, sizes: $sizes, prices: $prices}';
  }
}