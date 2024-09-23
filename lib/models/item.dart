// lib/models/item.dart
class Item {
  final String productname;
  final int productcode;
  final String imageurl;
  final int price;
  final int quantity;
  final int toatal;

  Item({
    required this.productname,
    required this.productcode,
    required this.imageurl,
    required this.price,
    required this.quantity,
    required this.toatal,
  });
  // Factory method to create an Item from JSON
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      productname: json['product name'],
      productcode: json['code'],
      imageurl: json['imageurl'],
      price: json['price'],
      quantity: json['quantity'],
      toatal: json['total']
    );
  }

  // Method to convert an Item to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': productname,
      'code': productcode,
      'image': imageurl,
      'price': price,
      'quantity': quantity,
    };
  }
}
