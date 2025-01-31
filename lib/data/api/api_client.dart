import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl =
      'https://www.themealdb.com/api/json/v1/1'; // replace with backend URL

  Future<dynamic> get(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl$endpoint'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'Failed to fetch data. Status Code: ${response.statusCode}');
    }
  }
}
