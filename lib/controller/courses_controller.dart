import 'package:edu/core/services/edu_api_services.dart';
import 'package:edu/model/courses_res.dart';
import 'package:flutter/material.dart';

class CoursesController with ChangeNotifier {
  bool isLoading = false;
  List<Datum> courses = [];

  Future<void> fetchCourses(String token) async {
    isLoading = true;
    notifyListeners();

    final response = await EduApiServices.fetchCourses(token);
    courses = List<Datum>.from(response?.data ?? []); 

    isLoading = false;
    notifyListeners();
  }
}
