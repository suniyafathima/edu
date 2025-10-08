import 'package:flutter/material.dart';
import 'package:edu/core/services/edu_api_services.dart';


class BannerController with ChangeNotifier {
  bool isLoading = false;
  String? bannerUrl;

  Future<void> fetchBanner(String token) async {
    isLoading = true;
    notifyListeners();

    final response = await EduApiServices.fetchBanner(token);
    isLoading = false;

    if (response != null) {
      bannerUrl = response.data;
      notifyListeners();
    } else {
      print('Failed to load banner');
    }
  }
}
