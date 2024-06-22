import 'package:flutter/material.dart';
import 'package:mosque/model/lesson.dart';

class LessonCard extends StatelessWidget {
  final Lesson lesson;

  const LessonCard({Key? key, required this.lesson}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        lesson.isPlaying ? Icons.play_arrow : Icons.play_circle_outline,
        size: 30,
      ),
      title: Text(
        lesson.name,
        style: const TextStyle(fontSize: 16),
      ),
      subtitle: Text(
        lesson.duration,
        style: const TextStyle(fontSize: 12),
      ),
      trailing: Icon(
        lesson.isCompleted ? Icons.check_circle : Icons.lock,
        color: lesson.isCompleted ? Colors.green : null,
        size: 24,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      visualDensity: VisualDensity.compact,
    );
  }
}
