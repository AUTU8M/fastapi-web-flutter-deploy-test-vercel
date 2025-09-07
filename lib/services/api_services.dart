import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  final String baseurl = "https://mock-fastapi-backend.onrender.com";

  Future<String> getStatus() async {
    final response = await get(Uri.parse("$baseurl/"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['status'];
    } else {
      throw Exception("Failed to load data");
    }
  }

  Future<String> pingResponse() async {
    final response = await get(Uri.parse("$baseurl/ping"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['message'];
    } else {
      throw Exception("Failed to load data");
    }
  }

  Future<String> echoResponse(String msg) async {
    final response = await http.post(
      Uri.parse("$baseurl/echo"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"message": msg}),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['echo'];
    } else {
      throw Exception("Failed to load echo data");
    }
  }
}
