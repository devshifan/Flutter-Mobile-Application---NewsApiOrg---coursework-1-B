import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Categories'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildCategoryButton(context, 'business', Icons.business),
            _buildCategoryButton(context, 'technology', Icons.computer),
            _buildCategoryButton(context, 'science', Icons.science),
            _buildCategoryButton(context, 'sports', Icons.sports),
            _buildCategoryButton(context, 'health', Icons.medical_information),
            _buildCategoryButton(context, 'entertainment', Icons.music_note),
            // Add more category buttons as needed
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryButton(
      BuildContext context, String category, IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.pushNamed(context, '/$category');
        },
        icon: Icon(icon),
        label: Text(category.capitalize()), // Capitalize the category name
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          textStyle: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

// Helper function to capitalize the first letter of a string
extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
