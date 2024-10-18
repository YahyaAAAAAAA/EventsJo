import 'package:events_jo/config/my_colors.dart';
import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  final String text;
  final IconData icon;
  final void Function()? onPressed;

  const HomeCard({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 100,
      decoration: BoxDecoration(
        color: MyColors.gray,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Icon(
              icon,
              color: MyColors.beige,
              size: 30,
            ),
          ),
          Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.normal,
                color: MyColors.lightYellow,
              ),
            ),
          ),
          IconButton(
            onPressed: onPressed,
            style: ButtonStyle(
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                padding: const WidgetStatePropertyAll(EdgeInsets.all(20)),
                backgroundColor: WidgetStatePropertyAll(MyColors.black)),
            icon: Icon(
              Icons.arrow_forward,
              color: MyColors.lightYellow,
            ),
          ),
        ],
      ),
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
