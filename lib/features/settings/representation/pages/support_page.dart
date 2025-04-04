import 'package:events_jo/config/extensions/build_context_extenstions.dart';
import 'package:events_jo/config/extensions/color_extensions.dart';
import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/settings/representation/components/settings_card.dart';
import 'package:events_jo/features/settings/representation/components/settings_sub_app_bar.dart';
import 'package:events_jo/features/settings/representation/components/settings_text_button.dart';
import 'package:events_jo/features/settings/representation/components/settings_text_field.dart';
import 'package:flutter/material.dart';

class SupportPage extends StatefulWidget {
  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  final TextEditingController subjectController = TextEditingController();

  final TextEditingController messageController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    subjectController.dispose();
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SettingsSubAppBar(
        title: 'Help & Support',
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 450,
          ),
          child: ListView(
            padding: const EdgeInsets.all(12),
            children: [
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
              20.height,
              SettingsCard(
                text: 'About Us',
                icon: CustomIcons.info,
                onTap: () => showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: GColors.whiteShade3,
                      content: Text(
                        'We are a team of four passionate Computer Science students from Hashemite University, united by our goal to make event planning easier for everyone in Jordan. EventsJo is our graduation project, reflecting our dedication to combining technical expertise with real-world solutions. Together, we aim to leave a positive mark by simplifying venue bookings and bringing convenience to users at their fingertips.',
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
                    );
                  },
                ),
              ),
              20.height,
              Text(
                'Contact Us',
                style: TextStyle(
                  color: GColors.black,
                  fontSize: kNormalFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              10.height,
              // Email Input
              SettingsTextField(
                controller: subjectController,
                hintText: 'Subject',
              ),

              20.height,

              // Message Input
              SettingsTextField(
                controller: messageController,
                hintText: 'Message',
                maxLines: 5,
              ),

              20.height,

              // Submit Button
              Center(
                child: SettingsTextButton(
                  text: 'Submit',
                  onPressed: () {
                    setState(() {
                      subjectController.clear();
                      messageController.clear();
                    });
                    context
                        .showSnackBar('Your message has been sent, Thank you');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
