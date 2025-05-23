import 'package:events_jo/config/enums/user_type_enum.dart';
import 'package:events_jo/config/extensions/build_context_extenstions.dart';
import 'package:events_jo/config/extensions/color_extensions.dart';
import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/auth/domain/entities/user_manager.dart';
import 'package:events_jo/features/auth/representation/cubits/auth_cubit.dart';
import 'package:events_jo/features/chat/representation/pages/chats_page.dart';
import 'package:events_jo/features/home/presentation/components/home_app_bar.dart';
import 'package:events_jo/features/owner/representation/pages/creation/owner_main_page.dart';
import 'package:events_jo/features/settings/representation/components/settings_card.dart';
import 'package:events_jo/features/settings/representation/cubits/settings_cubit.dart';
import 'package:events_jo/features/settings/representation/pages/account_page.dart';
import 'package:events_jo/features/settings/representation/pages/privacy_page.dart';
import 'package:events_jo/features/settings/representation/pages/support_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatefulWidget {
  final UserType userType;

  const SettingsPage({
    super.key,
    required this.userType,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
        isOwner: widget.userType == UserType.owner ? true : false,
        title: user?.name ?? 'Guest 123',
        onOwnerButtonTap: () => context.push(OwnerMainPage(user: user)),
        onChatsPressed: () => context.push(ChatsPage(user: user!)),
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
                        text: 'Privacy & Security',
                        icon: CustomIcons.lock,
                        onTap: () => context.push(const PrivacyPage()),
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
                      //help and support
                      SettingsCard(
                        text: 'Help and Support',
                        icon: CustomIcons.headphones,
                        onTap: () => context.push(SupportPage()),
                      ),

                      10.height,

                      //privacy and security
                      SettingsCard(
                        text: 'What is EventsJo',
                        icon: CustomIcons.messages_question,
                        onTap: () => showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            backgroundColor: GColors.whiteShade3,
                            content: Text(
                              'EventsJo is a comprehensive cross-platform mobile application designed to streamline the process of booking venues for various occasions in Jordan. Whether its a wedding, a football match, or a relaxing getaway at a farm, EventsJo connects users with available venues, making reservations simple and hassle-free. The app features user-friendly authentication, seamless payment options (cash or credit card), and detailed tracking of past and upcoming events.',
                              style: TextStyle(
                                color: GColors.black,
                                fontSize: kSmallFontSize,
                              ),
                            ),
                            actions: [
                              IconButton(
                                onPressed: () => context.pop(),
                                style: ButtonStyle(
                                    backgroundColor: WidgetStatePropertyAll(
                                        GColors.whiteShade3.shade600)),
                                icon: Text(
                                  'Done',
                                  style: TextStyle(
                                      color: GColors.royalBlue,
                                      fontSize: kSmallFontSize),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      10.height,

                      SettingsCard(
                        text: 'Logout',
                        icon: Icons.logout_rounded,
                        onTap: () => context.read<AuthCubit>().logout(
                              user!.uid,
                              user!.type,
                            ),
                      ),

                      10.height,

                      widget.userType == UserType.owner
                          ? Text(
                              'Your Events',
                              style: TextStyle(
                                color: GColors.black,
                                fontSize: kSmallFontSize + 2,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : 0.width,

                      5.height,

                      //farms
                      widget.userType == UserType.owner
                          ? SettingsCard(
                              text: 'Create and Manage Events',
                              icon: Icons.person_4_outlined,
                              onTap: () =>
                                  context.push(OwnerMainPage(user: user)),
                            )
                          : 0.width,
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
