import 'package:flutter/material.dart';

class MyOtherWidget extends StatelessWidget {
  const MyOtherWidget({
    super.key,
    required this.text,
    this.padding,
  });

  final String text;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(width: 2),
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(text),
            const SizedBox(width: 10),
            const Icon(
              Icons.account_balance_wallet_outlined,
            ),
          ],
        ),
      ),
    );
  }
}
