import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/home/presentation/components/appbar_button.dart';
import 'package:flutter/material.dart';

class AdminSubAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;

  const AdminSubAppBar({
    super.key,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Text(
          title ?? '',
          style: TextStyle(
            color: GColors.cyanShade6,
            fontSize: 25,
          ),
        ),
      ),
      centerTitle: true,
      leading: AppBarButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: Icons.arrow_back_ios_new,
        size: 25,
      ),
      leadingWidth: 90,
      toolbarHeight: 70,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20);
}