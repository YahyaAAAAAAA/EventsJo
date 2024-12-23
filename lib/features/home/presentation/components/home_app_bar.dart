import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/home/presentation/components/app_bar_button.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final void Function()? onPressed;
  final String title;

  const HomeAppBar({
    super.key,
    this.onPressed,
    this.title = '       ',
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      leading: AppBarButton(
        onPressed: onPressed,
        icon: Icons.person,
        size: 25,
      ),
      centerTitle: true,
      title: FittedBox(
        child: Text(
          title,
          style: TextStyle(
            color: GColors.black,
            fontSize: 25,
          ),
        ),
      ),
      actions: [
        AppBarButton(
          onPressed: () {},
          icon: CustomIcons.menu,
          size: 20,
        ),
      ],
      leadingWidth: 90,
      toolbarHeight: 70,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20);
}
