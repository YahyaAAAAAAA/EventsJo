import 'package:events_jo/config/custom_icons_icons.dart';
import 'package:events_jo/config/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:gradient_icon/gradient_icon.dart';

class EventsJoLogo extends StatelessWidget {
  const EventsJoLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        GradientIcon(
          icon: CustomIcons.eventsjo,
          gradient: LinearGradient(
            colors: MyColors.logoList,
          ),
          size: 80,
        ),
        Text(
          'EventsJo',
          style: TextStyle(
            color: MyColors.black,
            fontSize: 30,
          ),
        )
      ],
    );
  }
}
