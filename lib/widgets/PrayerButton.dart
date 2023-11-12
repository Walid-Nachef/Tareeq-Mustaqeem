import 'package:flutter/material.dart';

class PrayerButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const PrayerButton({
    Key? key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      // Expanded widget to ensure each button takes equal space
      child: Padding(
        padding: const EdgeInsets.all(4.0), // Padding between the buttons
        child: InkWell(
          onTap: onTap,
          child: Container(
            height: 56.0, // Fixed height for consistency
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue : Colors.transparent,
              border: Border.all(
                color: Colors.blue,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.blue,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
