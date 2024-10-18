import 'package:flutter/material.dart';

class MyProgressIndicator extends StatelessWidget {
  final Color color;
  const MyProgressIndicator({
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: color,
    );
  }
}
