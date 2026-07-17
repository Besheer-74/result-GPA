import 'package:flutter/material.dart';

import '../model/result.dart';
import '../model/student.dart';
import '../network/api_service.dart';

class ResultController extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Result? _result;

  Result? get result => _result;

  Student? _student;

  Student? get student => _student;

  Future<Result?> fetchResult(String studentCode, String nationalId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _result = await _apiService.fetchresult(
        studentCode: studentCode,
        nationalId: nationalId,
      );
      print('Fetched Result: ${_result?.success}');
      _student = _result?.student;
      return _result;
    } catch (e) {
      print(e);
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
