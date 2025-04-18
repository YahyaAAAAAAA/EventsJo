import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/auth/domain/entities/user_manager.dart';
import 'package:events_jo/features/auth/representation/cubits/auth_cubit.dart';
import 'package:events_jo/features/home/presentation/components/home_app_bar.dart';
import 'package:events_jo/features/home/presentation/components/sponserd_venue.dart';
import 'package:events_jo/features/home/presentation/pages/venue_search_delegate.dart';
import 'package:events_jo/features/weddings/representation/components/venue_search_bar.dart';
import 'package:events_jo/features/weddings/representation/cubits/venues/wedding_venues_cubit.dart';
import 'package:events_jo/features/weddings/representation/cubits/venues/wedding_venues_states.dart';
import 'package:events_jo/features/weddings/representation/pages/wedding_venues_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final AppUser? user;
  late final WeddingVenuesCubit weddingVenuesCubit;

  @override
  void initState() {
    super.initState();

    user = UserManager().currentUser;

    weddingVenuesCubit = context.read<WeddingVenuesCubit>();
    if (weddingVenuesCubit.cachedVenues == null) {
      weddingVenuesCubit.getAllVenues();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        isOwner: false,
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
                BlocBuilder<WeddingVenuesCubit, WeddingVenuesStates>(
                  builder: (context, state) => VenueSearchBar(
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
                ),

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
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    spacing: 5,
                    children: [
                      TextButton(
                        onPressed: () {},
                        style:
                            Theme.of(context).textButtonTheme.style?.copyWith(
                                  backgroundColor:
                                      WidgetStatePropertyAll(GColors.royalBlue),
                                ),
                        child: Text(
                          'Wedding Venues',
                          style: TextStyle(
                            color: GColors.white,
                            fontSize: kSmallFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Farms',
                          style: TextStyle(
                            color: GColors.black,
                            fontSize: kSmallFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Football Courts',
                          style: TextStyle(
                            color: GColors.black,
                            fontSize: kSmallFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                20.height,

                const SponserdVenue(selectedTab: 0),

                20.height,

                //popular venues text
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    Text(
                      "Popular Wedding Venues",
                      style: TextStyle(
                        color: GColors.black,
                        fontSize: kNormalFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () async =>
                          await weddingVenuesCubit.getAllVenues(),
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
                WeddingVenuesList(
                  user: user,
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
