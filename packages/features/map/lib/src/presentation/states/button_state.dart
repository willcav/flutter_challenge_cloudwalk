import 'dart:ui';

sealed class ButtonState {}

class ButtonSuccessState extends ButtonState {
  final String text;
  final VoidCallback onPressed;

  ButtonSuccessState({
    required this.text,
    required this.onPressed,
  });
}

class ButtonErrorState extends ButtonState {
  final String text;
  final VoidCallback tryAgain;

  ButtonErrorState({
    required this.text,
    required this.tryAgain,
  });
}

class ButtonLoadingState extends ButtonState {}
