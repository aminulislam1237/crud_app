import 'package:flutter/material.dart';
import 'dart:convert';
import 'item.dart';

class ApiService {
  final String baseUrl = 'https://yourapi.com/api/items';

  get http => null; // Replace with your API endpoint

  Future<List<Item>> fetchItems() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => Item.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load items');
    }
  }

  Future<Item> createItem(Item item) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(item.toJson()),
    );

    if (response.statusCode == 201) {
      return Item.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create item');
    }
  }

  Future<Item> updateItem(Item item) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${item.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(item.toJson()),
    );

    if (response.statusCode == 200) {
      return Item.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update item');
    }
  }

  Future<void> deleteItem(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete item');
    }
  }
}