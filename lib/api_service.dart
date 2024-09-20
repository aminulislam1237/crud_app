// lib/services/api_service.dart
import 'dart:convert';
import 'package:crud_app/models/item.dart';
import 'package:http/http.dart' as http;

class ApiService {

  final String baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<Item>> fetchItems() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => Item.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load items');
    }
  }

  Future<void> createItem(Item item) async {
    await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(item.toJson()),
    );
  }

  Future<void> updateItem(Item item) async {
    await http.put(
      Uri.parse('$baseUrl/${item.productname}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(item.toJson()),
    );
  }

  Future<void> deleteItem(int id) async {
    await http.delete(Uri.parse('$baseUrl/$id'));
  }
}
