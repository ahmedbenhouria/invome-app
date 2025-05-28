import 'package:flutter/material.dart';

class ActionButtonWidget extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final VoidCallback onPressed;
  final double width;

  const ActionButtonWidget({
    super.key,
    required this.text,
    required this.color,
    required this.textColor,
    required this.onPressed,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SizedBox(
        width: width,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(vertical: 11),
            elevation: 0,
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 1),
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
