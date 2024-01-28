import 'package:flutter/material.dart';
import 'package:news_app/provider/viewed_news_provider.dart';
import 'package:news_app/screens/business_news_screen.dart';
import 'package:news_app/screens/category_screen.dart';
import 'package:news_app/screens/entertainment_news_screen.dart';
import 'package:news_app/screens/health_news_screen.dart';
import 'package:news_app/screens/science_news_screen.dart';
import 'package:news_app/screens/sports_news_screen.dart';
import 'package:news_app/screens/technolgy_news_screen.dart';
import 'package:news_app/screens/viewed_news_screen.dart';
import 'package:news_app/screens/welcome_screen.dart';
import 'package:provider/provider.dart';

// void main() {
//   runApp(MyApp());
// }
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ViewedNewsProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/category': (context) => CategoryScreen(),
        '/technology': (context) => TechnolgyNewsScreen(category: 'technology'),
        '/business': (context) => BusinessNewsScreen(category: 'business'),
        '/science': (context) => ScienceNewsScreen(category: 'science'),
        '/health': (context) => HealthNewsScreen(category: 'health'),
        '/entertainment': (context) =>
            EntertainmentNewsScreen(category: 'entertainment'),
        '/sports': (context) => SportsNewsScreen(category: 'sports'),
        '/viewed_news': (context) => ViewedNewsScreen(), // Add this line
        // Add routes for other categories/screens
      },
    );
  }
}
