import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(TrackPlannerApp());
}

class TrackPlannerApp extends StatelessWidget {
  const TrackPlannerApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Track Planner',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: Color(0xFFF5F5F5),
        fontFamily: 'Roboto',
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFFE1BEE7),
          foregroundColor: Color(0xFF424242),
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Color(0xFF424242),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
