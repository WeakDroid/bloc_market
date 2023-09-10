import 'package:flutter/material.dart';
import '../styles/button_styles.dart';
import '../styles/text_styles.dart';

class QuantityButtons extends StatelessWidget {
  final int itemCount;
  final double productPrice;
  final Function(int) onIncrement;
  final Function(int) onDecrement;

  const QuantityButtons({
    Key? key,
    required this.itemCount,
    required this.productPrice,
    required this.onIncrement,
    required this.onDecrement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: buttonStyle,
          onPressed: () {
            if (itemCount > 1) {
              onDecrement(itemCount - 1);
            }
          },
          child: const Text(
            "-",
            style: AppTextStyles.buttonDark,
          ),
        ),
        const SizedBox(width: 12),
        ElevatedButton(
          style: buttonStyle,
          onPressed: () {
            onIncrement(itemCount + 1);
          },
          child: const Text(
            "+",
            style: AppTextStyles.buttonDark,
          ),
        ),
      ],
    );
  }
}
