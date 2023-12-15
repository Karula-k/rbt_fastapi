import 'dart:convert';
import 'package:barang_app/api/barang.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String _baseUrl = 'http://192.168.1.7:8080';

  Future<List<Barang>> readData() async {
    var endpoint = '$_baseUrl/';
    final response = await http.get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Barang.fromJson(json)).toList();
    } else {
      throw Exception("failed to fetch api");
    }
  }

  Future<http.Response> addItem(Barang barang) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/barang/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(barang.toJson()),
    );

    return response;
  }

  Future<http.Response> editItem(int id, Barang barang) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/barang/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(barang.toJson()),
    );

    return response;
  }

  Future<http.Response> deleteItem(int id) async {
    final response = await http.delete(Uri.parse('$_baseUrl/barang/$id'));

    return response;
  }
}
