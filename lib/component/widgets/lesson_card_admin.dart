import 'package:flutter/material.dart';
import 'package:mosque/model/section_model.dart';

class LessonCardAdmin extends StatelessWidget {
  final Lesson lesson;
  final bool isPlaying;
  final bool isSelected;

  const LessonCardAdmin({
    super.key,
    required this.lesson,
    required this.isPlaying,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isSelected ? Colors.blueAccent.withOpacity(0.1) : Colors.white,
        border: isSelected
            ? Border.all(color: Colors.blueAccent, width: 2)
            : Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: ListTile(
        leading: Icon(
          isPlaying ? Icons.play_arrow : Icons.play_circle_outline,
          size: 30,
          color: isPlaying ? Colors.blueAccent : Colors.grey,
        ),
        title: Text(
          lesson.title ?? '',
          style: TextStyle(
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Colors.blueAccent : Colors.black,
          ),
        ),
        subtitle: Text(
          lesson.duration ?? '',
          style: const TextStyle(fontSize: 12),
        ),
        trailing: const Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 24,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        visualDensity: VisualDensity.compact,
      ),
    );
  }
}
