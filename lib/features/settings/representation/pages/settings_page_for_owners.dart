import 'package:events_jo/config/extensions/build_context_extenstions.dart';
import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/global_snack_bar.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/auth/domain/entities/user_manager.dart';
import 'package:events_jo/features/auth/representation/cubits/auth_cubit.dart';
import 'package:events_jo/features/home/presentation/components/home_app_bar.dart';
import 'package:events_jo/features/owner/representation/pages/venues/owner_venues_tab_page.dart';
import 'package:events_jo/features/owner/representation/pages/creation/owner_page.dart';
import 'package:events_jo/features/settings/representation/components/settings_card.dart';
import 'package:events_jo/features/settings/representation/cubits/settings_cubit.dart';
import 'package:events_jo/features/settings/representation/pages/account_page.dart';
import 'package:events_jo/features/settings/representation/pages/notifications_page.dart';
import 'package:events_jo/features/settings/representation/pages/privacy_page.dart';
import 'package:events_jo/features/settings/representation/pages/support_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPageForOwners extends StatefulWidget {
  const SettingsPageForOwners({super.key});

  @override
  State<SettingsPageForOwners> createState() => _SettingsPageForOwnersState();
}

class _SettingsPageForOwnersState extends State<SettingsPageForOwners> {
  late final AppUser? user;
  late final SettingsCubit settingsCubit;

  @override
  void initState() {
    super.initState();

    //get user
    user = UserManager().currentUser;

    //get cubit
    settingsCubit = context.read<SettingsCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        title: user?.name ?? 'Guest 123',
        onOwnerButtonTap: () => context.push(OwnerPage(user: user)),
        isOwner: true,
        onPressed: () => context.read<AuthCubit>().logout(
              user!.uid,
              user!.type,
            ),
      ),
      body: MediaQuery.of(context).size.width >= 300
          ? Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 450,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: ListView(
                    children: [
                      //account
                      Text(
                        'Account',
                        style: TextStyle(
                          color: GColors.black,
                          fontSize: kSmallFontSize + 2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SettingsCard(
                        text: 'Your Account',
                        icon: CustomIcons.portrait,
                        onTap: () => context.push(
                          AccountPage(settingsCubit: settingsCubit),
                        ),
                      ),
                      10.height,
                      SettingsCard(
                        text: 'Notifications',
                        icon: CustomIcons.bell,
                        onTap: () => context.push(NotificationsPage()),
                      ),
                      10.height,

                      Text(
                        'Support',
                        style: TextStyle(
                          color: GColors.black,
                          fontSize: kSmallFontSize + 2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      5.height,
                      //privacy and security
                      SettingsCard(
                        text: 'Privacy & Security',
                        icon: CustomIcons.lock,
                        onTap: () => context.push(const PrivacyPage()),
                      ),
                      10.height,

                      //help and support
                      SettingsCard(
                        text: 'Help and Support',
                        icon: CustomIcons.headphones,
                        onTap: () => context.push(SupportPage()),
                      ),
                      10.height,
                      Text(
                        'Your Events',
                        style: TextStyle(
                          color: GColors.black,
                          fontSize: kSmallFontSize + 2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      5.height,
                      //venues
                      SettingsCard(
                        text: 'Your Venues',
                        icon: CustomIcons.rings_wedding_1,
                        onTap: () => context.push(const OwnerVenuesTabPage()),
                      ),
                      10.height,

                      //farms
                      SettingsCard(
                        text: 'Your Farms',
                        icon: CustomIcons.wheat,
                        onTap: () => GSnackBar.show(
                          context: context,
                          text: 'Coming Soon',
                        ),
                      ),
                      10.height,

                      //courts
                      SettingsCard(
                        text: 'Your Courts',
                        icon: CustomIcons.football_1,
                        onTap: () => GSnackBar.show(
                          context: context,
                          text: 'Coming Soon',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : 0.width,
      bottomNavigationBar: Divider(
        color: GColors.poloBlue,
        thickness: 0.5,
        indent: 10,
        endIndent: 10,
        height: 0,
      ),
    );
  }
}
