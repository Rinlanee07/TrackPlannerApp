import 'package:flutter/material.dart';
import '../models/task.dart';
import 'home_page.dart';
import 'planner_page.dart';

class SummaryPage extends StatelessWidget {
  final List<Task> tasks;

  const SummaryPage({super.key, required this.tasks});

  void _navigateTo(BuildContext context, int index) {
    if (index == 2) return; // อยู่หน้า Summary แล้ว
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
    if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              PlannerPage(tasks: tasks, onTasksUpdated: (_) {}),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Summary'), centerTitle: true),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 15,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.assignment, size: 60, color: Color(0xFFE1BEE7)),
              SizedBox(height: 20),
              Text(
                'Total Planned Tasks',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF424242),
                ),
              ),
              SizedBox(height: 10),
              Text(
                '${tasks.length}',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE1BEE7),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Planner',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Summary',
          ),
        ],
        currentIndex: 2,
        selectedItemColor: Color(0xFFE1BEE7),
        unselectedItemColor: Color(0xFF424242),
        onTap: (index) => _navigateTo(context, index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 10,
      ),
    );
  }
}
