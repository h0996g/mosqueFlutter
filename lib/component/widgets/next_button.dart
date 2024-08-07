import 'package:flutter/material.dart';

class RectangularButton extends StatelessWidget {
  const RectangularButton({
    super.key,
    required this.onPressed,
    required this.label,
  });

  final VoidCallback? onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black87,
        backgroundColor: Colors.white, // Text color for light button
        elevation: 2, // Button shadow
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Rounded corners
          side: BorderSide(
            color: Colors.grey[300]!, // Subtle border color
          ),
        ),
      ),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              letterSpacing: 1.5, // Adjusted letter spacing
              fontSize: 20, // Adjusted font size
              fontWeight: FontWeight.w500, // Medium weight font
              color: onPressed != null
                  ? Colors.black87
                  : Colors.grey[500], // Text color based on button state
            ),
          ),
        ),
      ),
    );
  }
}
