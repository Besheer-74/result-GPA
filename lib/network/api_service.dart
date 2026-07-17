import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/result.dart';

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:8000';
  Future<Result> fetchresult({
    required String studentCode,
    required String nationalId,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/results'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'student_code': studentCode,
          'national_id': nationalId,
        }),
      );
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return Result.fromJson(json);
      } else {
        throw Exception('Failed to load result');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
