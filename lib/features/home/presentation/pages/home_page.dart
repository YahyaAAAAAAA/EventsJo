import 'package:events_jo/config/enums/user_type_enum.dart';
import 'package:events_jo/config/extensions/build_context_extenstions.dart';
import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/auth/domain/entities/user_manager.dart';
import 'package:events_jo/features/auth/representation/cubits/auth_cubit.dart';
import 'package:events_jo/features/chat/representation/pages/chats_page.dart';
import 'package:events_jo/features/events/courts/representation/cubits/courts/football_court_cubit.dart';
import 'package:events_jo/features/events/courts/representation/cubits/courts/football_court_states.dart';
import 'package:events_jo/features/events/courts/representation/pages/football_courts_list.dart';
import 'package:events_jo/features/home/presentation/components/home_app_bar.dart';
import 'package:events_jo/features/home/presentation/components/sponserd_venue.dart';
import 'package:events_jo/features/events/courts/representation/components/court_search_delegate.dart';
import 'package:events_jo/features/events/weddings/representation/components/venue_search_delegate.dart';
import 'package:events_jo/features/events/shared/representation/components/events_search_bar.dart';
import 'package:events_jo/features/events/weddings/representation/cubits/venues/wedding_venues_cubit.dart';
import 'package:events_jo/features/events/weddings/representation/cubits/venues/wedding_venues_states.dart';
import 'package:events_jo/features/events/weddings/representation/pages/wedding_venues_list.dart';
import 'package:events_jo/features/owner/representation/pages/creation/owner_main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  final UserType userType;

  const HomePage({
    super.key,
    required this.userType,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final AppUser? user;
  late final WeddingVenuesCubit weddingVenuesCubit;
  late final FootballCourtsCubit footballCourtCubit;

  final TextEditingController searchController = TextEditingController();
  int selectedTab = 0;

  @override
  void initState() {
    super.initState();

    user = UserManager().currentUser;

    weddingVenuesCubit = context.read<WeddingVenuesCubit>();
    footballCourtCubit = context.read<FootballCourtsCubit>();

    if (weddingVenuesCubit.cachedVenues == null) {
      weddingVenuesCubit.getAllVenues();
    }

    if (footballCourtCubit.cachechCourts == null) {
      footballCourtCubit.getAllCourts();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        isOwner: widget.userType == UserType.owner ? true : false,
        title: user?.name ?? 'Guest 123',
        onOwnerButtonTap: () => context.push(OwnerMainPage(user: user)),
        onChatsPressed: () => context.push(ChatsPage(user: user!)),
        onPressed: () =>
            context.read<AuthCubit>().logout(user!.uid, user!.type),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: kListViewWidth),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: ListView(
              children: [
                selectedTab == 0
                    ? BlocBuilder<WeddingVenuesCubit, WeddingVenuesStates>(
                        builder: (context, state) => EventSearchBar(
                          hintText: 'Search Venues...',
                          onPressed: state is WeddingVenuesLoaded
                              ? () => showSearch(
                                    context: context,
                                    delegate: VenueSearchDelegate(
                                      context,
                                      state.venues,
                                      user,
                                    ),
                                  )
                              : null,
                        ),
                      )
                    : 0.width,

                selectedTab == 1
                    ? BlocBuilder<FootballCourtsCubit, FootballCourtsStates>(
                        builder: (context, state) => EventSearchBar(
                          hintText: 'Search Football Courts...',
                          onPressed: state is FootballCourtsLoaded
                              ? () => showSearch(
                                    context: context,
                                    delegate: CourtSearchDelegate(
                                      context,
                                      state.courts,
                                      user,
                                    ),
                                  )
                              : null,
                        ),
                      )
                    : 0.width,

                10.height,

                //categories text
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      "Categories",
                      style: TextStyle(
                        color: GColors.black,
                        fontSize: kNormalFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "See All",
                      style: TextStyle(
                        color: GColors.black,
                        fontSize: kSmallFontSize,
                      ),
                    ),
                  ],
                ),

                5.height,

                //categories buttons
                SizedBox(
                  height: 50,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      IconButton(
                        onPressed: () => setState(() => selectedTab = 0),
                        style:
                            Theme.of(context).textButtonTheme.style?.copyWith(
                                  backgroundColor: WidgetStatePropertyAll(
                                    selectedTab == 0
                                        ? GColors.royalBlue
                                        : GColors.white,
                                  ),
                                  padding: const WidgetStatePropertyAll(
                                      EdgeInsets.symmetric(horizontal: 20)),
                                ),
                        icon: Text(
                          'Wedding Venues',
                          style: TextStyle(
                            color: selectedTab == 0
                                ? GColors.white
                                : GColors.black,
                            fontSize: kSmallFontSize,
                            fontWeight: selectedTab == 0
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                      10.width,
                      IconButton(
                        onPressed: () => setState(() => selectedTab = 1),
                        style:
                            Theme.of(context).textButtonTheme.style?.copyWith(
                                  backgroundColor: WidgetStatePropertyAll(
                                      selectedTab == 1
                                          ? GColors.royalBlue
                                          : GColors.white),
                                  padding: const WidgetStatePropertyAll(
                                      EdgeInsets.symmetric(horizontal: 20)),
                                ),
                        icon: Text(
                          'Football Courts',
                          style: TextStyle(
                            color: selectedTab == 1
                                ? GColors.white
                                : GColors.black,
                            fontSize: kSmallFontSize,
                            fontWeight: selectedTab == 1
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                      10.width,
                      IconButton(
                        onPressed: () => context.showSnackBar('Coming Soon'),
                        style:
                            Theme.of(context).textButtonTheme.style?.copyWith(
                                  backgroundColor: WidgetStatePropertyAll(
                                      selectedTab == 2
                                          ? GColors.royalBlue
                                          : GColors.white),
                                  padding: const WidgetStatePropertyAll(
                                      EdgeInsets.symmetric(horizontal: 20)),
                                ),
                        icon: Row(
                          spacing: 5,
                          children: [
                            Icon(
                              Icons.lock_outline_rounded,
                              color: GColors.black.withValues(alpha: 0.5),
                              size: kSmallIconSize,
                            ),
                            Text(
                              'Farms',
                              style: TextStyle(
                                color: GColors.black.withValues(alpha: 0.5),
                                fontSize: kSmallFontSize,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                20.height,

                SponsoredVenue(selectedTab: selectedTab, user: user!),

                20.height,

                //popular venues text
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedTab == 0
                          ? "Popular Wedding Venues"
                          : "Popular Football Courts",
                      style: TextStyle(
                        color: GColors.black,
                        fontSize: kNormalFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        if (selectedTab == 0) {
                          await weddingVenuesCubit.getAllVenues();
                        }
                        if (selectedTab == 1) {
                          await footballCourtCubit.getAllCourts();
                        }
                      },
                      style: Theme.of(context).iconButtonTheme.style?.copyWith(
                            backgroundColor: WidgetStatePropertyAll(
                              GColors.scaffoldBg,
                            ),
                          ),
                      icon: const Icon(
                        Icons.refresh_rounded,
                      ),
                    ),
                  ],
                ),

                //venus list
                AnimatedCrossFade(
                  duration: const Duration(milliseconds: 300),
                  crossFadeState: selectedTab == 0
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  firstChild:
                      WeddingVenuesList(key: const ValueKey(0), user: user),
                  secondChild:
                      FootballCourtsList(key: const ValueKey(1), user: user),
                ),
              ],
            ),
          ),
        ),
      ),
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
