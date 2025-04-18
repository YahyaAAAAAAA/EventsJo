import 'package:events_jo/config/extensions/int_extensions.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/location/domain/entities/ej_location.dart';
import 'package:events_jo/features/location/representation/cubits/location_cubit.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';
import 'package:events_jo/features/weddings/representation/components/venue_ratings.dart';
import 'package:flutter/material.dart';

class VenueNameRatingAndLocation extends StatelessWidget {
  final WeddingVenue? weddingVenue;
  final LocationCubit? locationCubit;
  final EjLocation? venueLocation;
  final AppUser user;

  const VenueNameRatingAndLocation({
    super.key,
    required this.weddingVenue,
    required this.user,
    this.locationCubit,
    this.venueLocation,
  });

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).size.width >= 175
        ? Container(
            constraints: const BoxConstraints(minWidth: 362),
            decoration: BoxDecoration(
              color: GColors.white,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    //venue name
                    Text(
                      weddingVenue?.name ?? 'Venue 123',
                      style: TextStyle(
                        color: GColors.black,
                        fontSize: kSmallFontSize,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    //rate
                    VenueRating(
                      rates: weddingVenue?.rates ?? [],
                      user: user,
                    ),
                  ],
                ),

                //location
                IconButton(
                  onPressed: () => locationCubit!.showMapDialogPreview(context,
                      userLocation: venueLocation!),
                  icon: const Icon(
                    CustomIcons.map_marker,
                  ),
                ),
              ],
            ),
          )
        : 0.width;
  }
}
