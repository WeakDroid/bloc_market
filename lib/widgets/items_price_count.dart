import 'package:flutter/material.dart';
import '../styles/button_styles.dart';
import '../styles/text_styles.dart';

class ItemsPriceCount extends StatefulWidget {
  const ItemsPriceCount({
    super.key,
  });

  @override
  _ItemsPriceCountState createState() => _ItemsPriceCountState();
}

class _ItemsPriceCountState extends State<ItemsPriceCount> {
  int selectedCount = 1;
  int activeButtonIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: Alignment.center,
          child: RichText(
            text: TextSpan(
              text: "$selectedCount ",
              style: AppTextStyles.buttonDark,
              children: const <TextSpan>[
                TextSpan(
                  text: ' Octave',
                  style: AppTextStyles.buttonDark,
                )
              ],
            ),
          ),
        ),
        _buildDecrementButton(),
        _buildIncrementButton(),
      ],
    );
  }

  Widget _buildIncrementButton() {
    return ElevatedButton(
      onPressed: () {
        int newCount = selectedCount + 1;
        if (newCount > 3) {
          newCount = 1;
        }
        setState(() {
          selectedCount = newCount;
          activeButtonIndex = newCount == 0 ? -1 : 1;
        });
      },
      style: productCountStyle,
      child: const Text(
        "+1",
        style: AppTextStyles.buttonDark,
      ),
    );
  }

  Widget _buildDecrementButton() {
    return ElevatedButton(
      onPressed: () {
        int newCount = selectedCount - 1;
        if (newCount < 1) {
          newCount = 3;
        }
        setState(() {
          selectedCount = newCount;
          activeButtonIndex = newCount == 1 ? -1 : 0;
        });
      },
      style: productCountStyle,
      child: const Text(
        "-1",
        style: AppTextStyles.buttonDark,
      ),
    );
  }
}
