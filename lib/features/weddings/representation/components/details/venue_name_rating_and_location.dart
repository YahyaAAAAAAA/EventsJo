import 'package:events_jo/config/utils/custom_icons_icons.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/gradient_text.dart';
import 'package:events_jo/features/location/domain/entities/user_location.dart';
import 'package:events_jo/features/location/representation/cubits/location_cubit.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';
import 'package:events_jo/features/weddings/representation/components/venue_rating.dart';
import 'package:events_jo/features/weddings/representation/components/venue_details_button.dart';
import 'package:flutter/material.dart';

class VenueNameRatingAndLocation extends StatelessWidget {
  const VenueNameRatingAndLocation({
    super.key,
    required this.padding,
    required this.weddingVenue,
    required this.locationCubit,
    required this.venueLocation,
  });

  final double padding;
  final WeddingVenue weddingVenue;
  final LocationCubit locationCubit;
  final UserLocation venueLocation;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: GColors.white,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      padding: EdgeInsets.all(padding),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              //venue name
              GradientText(
                weddingVenue.name,
                gradient: LinearGradient(
                  colors: GColors.logoGradient,
                ),
                style: TextStyle(
                  color: GColors.royalBlue,
                  fontSize: 28,
                ),
              ),

              //rate
              VenueRating(weddingVenue: weddingVenue, size: 20),
            ],
          ),

          //location
          VenueDetailsButton(
            onPressed: () => locationCubit.showMapDialogPreview(context,
                userLocation: venueLocation),
            icon: CustomIcons.map_marker,
            iconSize: 30,
            padding: 18,
          ),
        ],
      ),
    );
  }
}