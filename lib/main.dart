import 'package:flutter/material.dart';
import 'item.dart';
import 'api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD App',
      theme: ThemeData(primarySwatch: Colors.green),
      home: ItemList(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ItemList extends StatefulWidget {
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
    setState(() {});
  }

  void _addItem() async {
    final newItem = Item(id: '', name: _controller.text);
    final createdItem = await apiService.createItem(newItem);
    setState(() {
      items.add(createdItem);
    });
    _controller.clear();
  }

  void _updateItem(Item item) async {
    final updatedItem = Item(id: item.id, name: _controller.text);
    await apiService.updateItem(updatedItem);
    _fetchItems();
  }

  void _deleteItem(String id) async {
    await apiService.deleteItem(id);
    _fetchItems();
  }

  void _showDialog({Item? item}) {
    if (item != null) {
      _controller.text = item.name;
    } else {
      _controller.clear();
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(item == null ? 'Add Item' : 'Update Item'),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: 'Item name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (item == null) {
                  _addItem();
                } else {
                  _updateItem(item);
                }
                Navigator.of(context).pop();
              },
              child: Text(item == null ? 'Add' : 'Update'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD App with API'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ListTile(
            title: Text(item.name),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _showDialog(item: item),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteItem(item.id),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showDialog(),
        child: Icon(Icons.add),
      ),
    );
  }
}