import 'dart:io';

import 'package:crud_app/models/form_page.dart';
import 'package:crud_app/models/item.dart';
import 'package:flutter/material.dart';
import 'api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD App',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const ItemList(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ItemList extends StatefulWidget {
  const ItemList({super.key});

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  List<Item> items = [];
  final ApiService apiService = ApiService();
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchItems();
  }

  Future<void> _fetchItems() async {
   items = await apiService.fetchItems();
   print(items);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
            alignment: Alignment.center,
            child: Text('CRUD App',)),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.add), // Replace with your desired icon
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductFormPage()),);
            },
          ),
        ],
      ),
      body:
      ListView.separated(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ListTile(
            title: Row(
              children: [
                Text(item.productname.toString()),

                Expanded(child: Text(item.productcode as String)),
              ],
            ),
            subtitle: Text(item.price as String,style: TextStyle(
              fontSize: 15,
            ),),
          );
        }, separatorBuilder: (BuildContext context, int index) {
          return Divider();
      },
      )
    );
  }
}