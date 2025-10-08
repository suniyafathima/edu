import 'package:edu/core/services/edu_api_services.dart';
import 'package:flutter/material.dart';
import 'package:edu/model/material_res.dart';


class MaterialsController with ChangeNotifier {
  bool isLoading = false;
  List<Datum> materials = [];

  Future<void> fetchMaterials(String token) async {
    isLoading = true;
    notifyListeners();

    final response = await EduApiServices.fetchMaterials(token);
    materials = response?.data ?? [];

    isLoading = false;
    notifyListeners();
  }
}
