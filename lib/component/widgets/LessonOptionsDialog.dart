import 'package:flutter/material.dart';
import 'package:mosque/model/section_model.dart';

class LessonOptionsDialog extends StatelessWidget {
  final Lesson lesson;
  final VoidCallback onShowQuiz;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const LessonOptionsDialog({
    super.key,
    required this.lesson,
    required this.onShowQuiz,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Lesson Options',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.quiz),
              title: const Text('Show Quiz'),
              onTap: onShowQuiz,
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit Lesson'),
              onTap: onEdit,
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Delete Lesson'),
              onTap: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
