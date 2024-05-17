import 'package:flutter/material.dart';

class ButtonMapWidget extends StatelessWidget {
  const ButtonMapWidget({
    required this.child, super.key,
    this.textColor,
    this.backgroundColor,
    this.onPressed,
  });

  final Widget child;
  final Color? textColor;
  final Color? backgroundColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: _buildButton(),
        ),
      ],
    );

  Widget _buildButton() => TextButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          const EdgeInsets.all(12),
        ),
        textStyle: MaterialStateProperty.all(
          const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        foregroundColor:
            MaterialStateProperty.all(backgroundColor ?? Colors.white),
        backgroundColor: MaterialStateProperty.all(textColor ?? Colors.black),
        shape: MaterialStateProperty.all(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(24),
            ),
          ),
        ),
      ),
      onPressed: onPressed,
      child: child,
    );
}
