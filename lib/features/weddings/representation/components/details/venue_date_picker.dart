import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class VenueDatePicker extends StatelessWidget {
  final DateTime minDate;
  final DateTime maxDate;

  const VenueDatePicker({
    super.key,
    required this.minDate,
    required this.maxDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 320,
      decoration: BoxDecoration(
        color: GColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DatePicker(
        minDate: minDate,
        maxDate: maxDate,
        currentDateDecoration: BoxDecoration(
          border: Border.all(
            color: GColors.royalBlue,
          ),
          borderRadius: BorderRadius.circular(50),
        ),
        slidersColor: GColors.royalBlue,
        highlightColor: GColors.royalBlue.withOpacity(0.2),
        splashColor: GColors.royalBlue.withOpacity(0.2),
        selectedCellDecoration: BoxDecoration(
          gradient: LinearGradient(
            colors: GColors.logoGradient,
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        daysOfTheWeekTextStyle: TextStyle(
          color: GColors.poloBlue,
        ),
        leadingDateTextStyle: TextStyle(
          color: GColors.royalBlue,
          fontSize: 21,
        ),
      ),
    );
  }
}