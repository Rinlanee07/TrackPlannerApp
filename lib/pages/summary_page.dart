import 'package:flutter/material.dart';
import '../models/task.dart';

class SummaryPage extends StatelessWidget {
  final List<Task> tasks;

  SummaryPage({required this.tasks});

  @override
  Widget build(BuildContext context) {
    final totalTasks = tasks.length;
    final completedTasks = tasks.where((task) => task.isCompleted).length;
    final pendingTasks = totalTasks - completedTasks;
    final totalHours = tasks.fold<double>(
      0.0,
      (sum, task) => sum + task.estimatedHours,
    );
    final completedHours = tasks
        .where((task) => task.isCompleted)
        .fold<double>(0.0, (sum, task) => sum + task.estimatedHours);
    final productivityPercentage = totalTasks > 0
        ? (completedTasks / totalTasks * 100)
        : 0.0;

    return Scaffold(
      appBar: AppBar(
        title: Text('Summary & Analytics'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFB3E5FC), // pastel blue
              Color(0xFFE1BEE7), // pastel purple
            ],
          ),
        ),
        child: SafeArea(
          child: tasks.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.analytics_outlined,
                        size: 100,
                        color: Colors.grey.shade400,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'No Data to Analyze',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Add some tasks in the Planner to see your analytics here!',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Progress Overview',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF424242), // dark grey
                        ),
                      ),
                      SizedBox(height: 20),

                      // Productivity Circle
                      Container(
                        padding: EdgeInsets.all(25),
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
                            Container(
                              width: 120,
                              height: 120,
                              child: Stack(
                                children: [
                                  Container(
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.grey.shade300,
                                        width: 8,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 120,
                                    height: 120,
                                    child: CircularProgressIndicator(
                                      value: productivityPercentage / 100,
                                      strokeWidth: 8,
                                      backgroundColor: Colors.transparent,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Color(0xFFE1BEE7),
                                      ),
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${productivityPercentage.round()}%',
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF424242),
                                            ),
                                          ),
                                          Text(
                                            'Complete',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Productivity Score',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF424242),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20),

                      // Statistics Grid
                      GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                        childAspectRatio: 1.2,
                        children: [
                          _buildStatCard(
                            'Total Tasks',
                            totalTasks.toString(),
                            Icons.assignment,
                            Color(0xFFF8BBD0), // pastel pink
                          ),
                          _buildStatCard(
                            'Completed',
                            completedTasks.toString(),
                            Icons.check_circle,
                            Color(0xFFB3E5FC), // pastel blue
                          ),
                          _buildStatCard(
                            'Pending',
                            pendingTasks.toString(),
                            Icons.pending,
                            Color(0xFFE1BEE7), // pastel purple
                          ),
                          _buildStatCard(
                            'Total Hours',
                            '${totalHours.toStringAsFixed(1)}h',
                            Icons.access_time,
                            Color(0xFF424242), // dark grey
                          ),
                        ],
                      ),

                      SizedBox(height: 20),

                      // Time Analysis
                      Container(
                        padding: EdgeInsets.all(20),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Time Analysis',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF424242),
                              ),
                            ),
                            SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Completed Hours:',
                                  style: TextStyle(color: Colors.grey.shade700),
                                ),
                                Text(
                                  '${completedHours.toStringAsFixed(1)}h',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFB3E5FC),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Remaining Hours:',
                                  style: TextStyle(color: Colors.grey.shade700),
                                ),
                                Text(
                                  '${(totalHours - completedHours).toStringAsFixed(1)}h',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFE1BEE7),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            LinearProgressIndicator(
                              value: totalHours > 0
                                  ? completedHours / totalHours
                                  : 0,
                              backgroundColor: Colors.grey.shade300,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFFB3E5FC),
                              ),
                              minHeight: 8,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  /// Card builder widget
  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black, blurRadius: 12, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 24, color: color),
          ),
          SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF424242),
            ),
          ),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
