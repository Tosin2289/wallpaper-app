import 'package:flutter/material.dart';

class HeadingText extends StatelessWidget {
  const HeadingText({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .headlineLarge!
            .copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
