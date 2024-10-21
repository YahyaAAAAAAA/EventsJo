import 'dart:ui';

import 'package:events_jo/config/my_colors.dart';
import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  final String text;
  final String image;
  final double width;
  final void Function()? onPressed;

  const HomeCard({
    super.key,
    required this.text,
    required this.image,
    required this.width,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          height: 100,
          decoration: BoxDecoration(
            color: MyColors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Spacer(flex: 2),
              Center(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 22,
                    color: MyColors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: onPressed,
                style: ButtonStyle(
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    padding: const WidgetStatePropertyAll(EdgeInsets.all(20)),
                    backgroundColor: WidgetStatePropertyAll(MyColors.red)),
                icon: const Icon(
                  Icons.arrow_forward_ios,
                ),
              ),
            ],
          ),
        ),
        Image.asset(
          image,
          width: width,
        ),
      ],
    );
  }
}

extension StringCasingExtension on String {
  String get toCapitalized =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String get toTitleCase => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized)
      .join(' ');
}
