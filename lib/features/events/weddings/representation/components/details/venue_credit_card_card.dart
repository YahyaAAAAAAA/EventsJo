import 'package:events_jo/config/extensions/build_context_extenstions.dart';
import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class VenueCreditCardForm extends StatelessWidget {
  final bool isRefundable;
  final void Function(bool)? onRefundableChanged;

  const VenueCreditCardForm({
    super.key,
    required this.isRefundable,
    this.onRefundableChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              Text(
                'Make booking refundable',
                style: TextStyle(
                  color: GColors.black,
                  fontSize: kSmallFontSize,
                ),
              ),
              GestureDetector(
                onTap: () => context.dialog(
                  pageBuilder: (context, _, __) {
                    return const AlertDialog(
                      content: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        spacing: 10,
                        children: [
                          Center(
                            child: Text(
                              'Refundable bookings allows you to refund your booking',
                              style: TextStyle(
                                fontSize: kSmallFontSize + 2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                              'You\'ll be charged %5 more if you choose refundable option.'),
                          Text(
                              'For venues you have untill the last week of the date of the booking.'),
                          Text(
                              'For football courts you have untill the last day of the date of the booking.'),
                        ],
                      ),
                    );
                  },
                ),
                child: const Icon(
                  Icons.info_outline_rounded,
                ),
              ),
              20.width,
              Transform.scale(
                scale: 0.8,
                child: Switch(
                  value: isRefundable,
                  onChanged: onRefundableChanged,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
