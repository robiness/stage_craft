import 'package:flutter/material.dart';

class MyOtherWidget extends StatelessWidget {
  const MyOtherWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
