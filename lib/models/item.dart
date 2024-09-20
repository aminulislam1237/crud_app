// lib/models/item.dart
class Item {
  final String productname;
  final int productcode;
  final int price;
  final int quantity;

  Item({
    required this.productname,
    required this.productcode,
    required this.price,
    required this.quantity,
  });
  // Factory method to create an Item from JSON
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      productname: json['product name'],
      productcode: json['code'],
      price: json['price'],
      quantity: json['quantity'],
    );
  }

  // Method to convert an Item to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': productname,
      'code': productcode,
      'price': price,
      'quantity': quantity,
    };
  }
}
