import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/home/presentation/components/appbar_button.dart';
import 'package:flutter/material.dart';

class VenuesAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppUser? user;
  final PreferredSize? bottom;

  const VenuesAppBar({
    super.key,
    required this.user,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        leading: AppBarButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icons.arrow_back_ios_new_rounded,
          size: 25,
        ),
        centerTitle: true,
        title: Text(
          'Wedding Venues in Jordan',
          style: TextStyle(
            color: GColors.black,
            fontSize: 20,
          ),
        ),
        bottom: bottom,
        actions: [
          AppBarButton(
            onPressed: () {},
            icon: CustomIcons.menu,
            size: 20,
          ),
        ],
        leadingWidth: 90,
        toolbarHeight: 70,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
      bottom == null ? kToolbarHeight + 20 : kToolbarHeight + 60);
}