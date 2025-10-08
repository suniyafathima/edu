
import 'package:edu/core/services/edu_api_services.dart';
import 'package:edu/model/sub_res.dart';
import 'package:flutter/material.dart';

class SubjectController with ChangeNotifier {
  bool isLoading = false;
  List<Datum> subjects = [];

  Future<void> fetchSubjects(BuildContext context, String token) async {
    isLoading = true;
    notifyListeners();

    final response = await EduApiServices.fetchSubjects(token);
    isLoading = false;

    if (response != null && response.data != null) {
      subjects = response.data!;
      notifyListeners();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to load subjects")),
      );
    }
  }
}