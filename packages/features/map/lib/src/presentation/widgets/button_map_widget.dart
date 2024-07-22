import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../states/button_state.dart';

class ButtonMapWidget extends StatelessWidget {
  const ButtonMapWidget({required this.buttonState});

  final ValueListenable<ButtonState> buttonState;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: buttonState.observer(
              builder: (_, state, __) => switch (state) {
                ButtonSuccessState() => _ButtonContentWidget(
                    onPressed: state.onPressed,
                    child: Text(state.text),
                  ),
                ButtonLoadingState() => const _ButtonContentWidget(
                    onPressed: null,
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  ),
                ButtonErrorState() => _ButtonContentWidget(
                    onPressed: state.tryAgain,
                    child: Text(state.text),
                  ),
              },
            ),
          ),
        ],
      );
}

class _ButtonContentWidget extends StatelessWidget {
  const _ButtonContentWidget({
    required this.child,
    this.onPressed,
  });

  final Widget child;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => TextButton(
        style: ButtonStyle(
          padding: WidgetStateProperty.all(
            const EdgeInsets.all(12),
          ),
          textStyle: WidgetStateProperty.all(
            const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          foregroundColor: WidgetStateProperty.all(Colors.white),
          backgroundColor: WidgetStateProperty.all(Colors.black),
          shape: WidgetStateProperty.all(
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
