import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {
  final bool value;
  final String leftLabel;
  final String rightLabel;
  final ValueChanged<bool> onChanged;

  const CustomSwitch({
    required this.value,
    required this.leftLabel,
    required this.rightLabel,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        final tapPosition = details.localPosition.dx;
        final widgetWidth = 200.0; // Fixed width of the widget
        if (tapPosition < widgetWidth / 2) {
          onChanged(false); // Tap on left side selects false
        } else {
          onChanged(true); // Tap on right side selects true
        }
      },
      child: Container(
        width: 200,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey, // Background color
          borderRadius: BorderRadius.circular(8), // Optional: rounded corners
        ),
        child: Stack(
          children: [
            // Animated thumb
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              left: value ? 100.0 : 0.0,
              top: 0,
              bottom: 0,
              width: 100.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue, // Thumb color
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            // Labels
            Row(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      leftLabel,
                      style: TextStyle(
                        color: value ? Colors.black : Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      rightLabel,
                      style: TextStyle(
                        color: value ? Colors.white : Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
