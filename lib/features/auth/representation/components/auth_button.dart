import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final IconData icon;

  const AuthButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: GColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.normal,
                    color: GColors.black,
                  ),
                ),
              ),
            ),
            MediaQuery.of(context).size.width > 140
                ? IconButton(
                    onPressed: onTap,
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(kOuterRadius),
                        ),
                      ),
                      backgroundColor:
                          WidgetStatePropertyAll(GColors.royalBlue),
                      padding: const WidgetStatePropertyAll(EdgeInsets.all(0)),
                    ),
                    icon: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Icon(
                        icon,
                        color: GColors.whiteShade3,
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
