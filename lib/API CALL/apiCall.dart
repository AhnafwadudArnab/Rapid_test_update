import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiCall { 
  static const String baseUrl = 'http://127.0.0.1:8000/';  // Update with your base URL
  static const String api = 'api/';
  static const String userProfile = 'profile/';  // Assuming profile endpoint is api/profile/

  // Method to get user profile
  static Future<Map<String, dynamic>> getUserProfile(String token) async {
    final Uri url = Uri.parse('$baseUrl$api$userProfile');
    try {
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},  // Using token for authorization
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);  // Parse the response body to map
      } else {
        throw Exception('Failed to load user profile. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to get user profile: $error');
    }
  }

  // Method to update user profile
  static Future<Map<String, dynamic>> updateUserProfile(String token, Map<String, dynamic> data) async {
    final Uri url = Uri.parse('$baseUrl$api$userProfile');

    try {
      final response = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(data),  // Encode the profile data into JSON
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);  // Return the updated profile data
      } else {
        throw Exception('Failed to update user profile. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to update user profile: $error');
    }
  }
}
