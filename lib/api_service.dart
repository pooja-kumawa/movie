import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const baseUrl = 'https://api.tvmaze.com';

  // Fetch all movies
  static Future<List<dynamic>> fetchMovies() async {
    final response = await http.get(Uri.parse('$baseUrl'));
    return json.decode(response.body);
  }

  // Search movies
  static Future<List<dynamic>> searchMovies(String query) async {
    final response = await http.get(Uri.parse('$baseUrl/search/shows?q=$query'));
    return json.decode(response.body);
  }
}
