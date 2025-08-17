class Task {
  final String title;
  final String description;
  final DateTime date;
  final double estimatedHours;
  bool isCompleted;

  Task({
    required this.title,
    required this.description,
    required this.date,
    required this.estimatedHours,
    this.isCompleted = false,
  });
}
