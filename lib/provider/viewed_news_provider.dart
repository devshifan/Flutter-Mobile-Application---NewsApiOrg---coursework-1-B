import 'package:flutter/material.dart';

class ViewedNewsProvider with ChangeNotifier {
  // Map to store viewed news for each category
  Map<String, List<String>> _viewedNewsMap = {};
  String _lastViewedCategory = '';

  String getLastViewedCategory() {
    return _lastViewedCategory;
  }

  // Getter to get the viewed news for a specific category
  List<String> getViewedNewsForCategory(String category) {
    return _viewedNewsMap[category] ?? [];
  }

  void setLastViewedCategory(String category) {
    _lastViewedCategory = category;
    notifyListeners();
  }

  // Method to add viewed news for a specific category
  void addViewedNews(String category, String newsTitle) {
    // Get the viewed news list for the category
    List<String> viewedNews = _viewedNewsMap[category] ?? [];

    // Add the news title to the list
    viewedNews.add(newsTitle);

    // Keep only the unique news titles
    viewedNews = viewedNews.toSet().toList();

    // Update the map with the new list
    _viewedNewsMap[category] = viewedNews;

    // Notify listeners about the change
    notifyListeners();
  }
}
