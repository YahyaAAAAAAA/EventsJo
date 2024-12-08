import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class ChangeUserTypeRow extends StatelessWidget {
  final bool isOwner;
  final void Function()? setUserType;
  final void Function()? setOwnerType;

  const ChangeUserTypeRow({
    super.key,
    required this.isOwner,
    required this.setUserType,
    required this.setOwnerType,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Wrap(
        runSpacing: 10,
        spacing: 10,
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          TextButton(
            onPressed: setUserType,
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(GColors.white),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              padding: const WidgetStatePropertyAll(
                EdgeInsets.all(12),
              ),
            ),
            child: Icon(
              Icons.person,
              size: 30,
              color: isOwner ? GColors.black : GColors.royalBlue,
            ),
          ),
          TextButton(
            onPressed: setOwnerType,
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(GColors.white),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              padding: const WidgetStatePropertyAll(
                EdgeInsets.all(12),
              ),
            ),
            child: Icon(
              Icons.person_4,
              size: 30,
              color: isOwner ? GColors.royalBlue : GColors.black,
            ),
          ),
          Text(
            isOwner ? 'Owner Account' : 'User Account',
            style: const TextStyle(
              fontSize: 18,
              overflow: TextOverflow.clip,
            ),
          ),
        ],
      ),
    );
  }
}
