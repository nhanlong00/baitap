import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class TaskModel {
  final String id;
  final String title;
  final String detailTask;
  final DateTime dateTime;
  final bool isCompleted;

  const TaskModel({
    required this.id,
    required this.title,
    required this.detailTask,
    required this.dateTime,
    this.isCompleted = false
  });

  String get formattedDate {
    return formatter.format(dateTime);
  }
}
