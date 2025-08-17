import 'package:flutter/material.dart';
import '../models/task.dart';
import 'planner_page.dart';
import 'summary_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  List<Task> tasks = [];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });

    _navigateTo(index);
  }

  void _navigateTo(int index) {
    if (index == 0) return; // อยู่หน้า Home แล้ว
    if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PlannerPage(
            tasks: tasks,
            onTasksUpdated: (updatedTasks) {
              setState(() {
                tasks = updatedTasks;
              });
            },
          ),
        ),
      );
    }
    if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SummaryPage(tasks: tasks)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Track Planner'), centerTitle: true),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFB3E5FC), Color(0xFFF8BBD0)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
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
                    children: [
                      Icon(Icons.schedule, size: 80, color: Color(0xFFE1BEE7)),
                      SizedBox(height: 20),
                      Text(
                        'Welcome to Track Planner',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF424242),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'จัดการงานของคุณ ติดตามเวลา และเพิ่มประสิทธิภาพการทำงานด้วยแพลนเนอร์📝',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF424242),
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                Row(
                  children: [
                    Expanded(
                      child: _buildNavCard(
                        'Plan Tasks',
                        'เพิ่มและจัดการงานประจำวันของคุณ',
                        Icons.add_task,
                        Color(0xFFF8BBD0),
                        () => _onItemTapped(1),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: _buildNavCard(
                        'View Summary',
                        'ติดตามความก้าวหน้า',
                        Icons.analytics,
                        Color(0xFFB3E5FC),
                        () => _onItemTapped(2),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                if (tasks.isNotEmpty)
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 10,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem('Total Tasks', tasks.length.toString()),
                        Container(
                          width: 1,
                          height: 30,
                          color: Colors.grey.shade300,
                        ),
                        _buildStatItem(
                          'Completed',
                          tasks.where((t) => t.isCompleted).length.toString(),
                        ),
                        Container(
                          width: 1,
                          height: 30,
                          color: Colors.grey.shade300,
                        ),
                        _buildStatItem(
                          'Pending',
                          tasks.where((t) => !t.isCompleted).length.toString(),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
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
        currentIndex: 0,
        selectedItemColor: Color(0xFFE1BEE7),
        unselectedItemColor: Color(0xFF424242),
        onTap: _navigateTo,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 10,
      ),
    );
  }

  Widget _buildNavCard(
    String title,
    String subtitle,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, size: 30, color: color),
            ),
            SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF424242),
              ),
            ),
            SizedBox(height: 5),
            Text(
              subtitle,
              style: TextStyle(fontSize: 12, color: Color(0xFF424242)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF424242),
          ),
        ),
        Text(label, style: TextStyle(fontSize: 12, color: Color(0xFF424242))),
      ],
    );
  }
}
