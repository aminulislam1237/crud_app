import 'package:flutter/material.dart';

class ProductFormPage extends StatefulWidget {
  @override
  _ProductFormPageState createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  String? _productName;
  String? _productCode;
  double? _price;
  int? _quantity;
  double _totalPrice = 0.0;

  void _calculateTotalPrice() {
    if (_price != null && _quantity != null) {
      setState(() {
        _totalPrice = _price! * _quantity!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Product Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the product name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _productName = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Product Code'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the product code';
                  }
                  return null;
                },
                onSaved: (value) {
                  _productCode = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the price';
                  }
                  return null;
                },
                onSaved: (value) {
                  _price = double.tryParse(value!);
                  _calculateTotalPrice();
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the quantity';
                  }
                  return null;
                },
                onSaved: (value) {
                  _quantity = int.tryParse(value!);
                  _calculateTotalPrice();
                },
              ),
              SizedBox(height: 20),
              Text(
                'Total Price: \$${_totalPrice.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Process the data (e.g., send to server)
                    print('Product Name: $_productName');
                    print('Product Code: $_productCode');
                    print('Price: $_price');
                    print('Quantity: $_quantity');
                    print('Total Price: $_totalPrice');
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
