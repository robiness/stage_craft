import 'package:flutter/material.dart';

class MyOtherWidget extends StatelessWidget {
  const MyOtherWidget({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
