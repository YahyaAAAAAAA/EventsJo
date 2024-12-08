import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';
import 'package:from_to_time_picker/from_to_time_picker.dart';

//* This widget let you pick between a range between 2 times
class TimePicker extends StatelessWidget {
  final dynamic Function(TimeOfDay, TimeOfDay)? onTab;
  const TimePicker({
    super.key,
    required this.onTab,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FittedBox(
        child: FromToTimePicker(
          onTab: onTab,
          dialogBackgroundColor: GColors.poloBlue.withOpacity(0.5),
          fromHeadlineColor: GColors.black,
          toHeadlineColor: GColors.black,
          timeBoxColor: GColors.royalBlue,
          upIconColor: GColors.white,
          downIconColor: GColors.white,
          dividerColor: GColors.poloBlue,
          timeTextColor: GColors.white,
          activeDayNightColor: GColors.royalBlue,
          dismissTextColor: GColors.redShade3,
          defaultDayNightColor: GColors.whiteShade3,
          doneTextColor: GColors.royalBlue,
          dismissText: '',
          showHeaderBullet: true,
          maxWidth: 500,
        ),
      ),
    );
  }
}
