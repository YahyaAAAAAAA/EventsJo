import 'package:cached_network_image/cached_network_image.dart';
import 'package:events_jo/config/my_colors.dart';
import 'package:events_jo/config/my_progress_indicator.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';
import 'package:flutter/material.dart';

class WeddingVenueCard extends StatelessWidget {
  final WeddingVenue weddingVenue;
  const WeddingVenueCard({
    super.key,
    required this.weddingVenue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListTile(
        // height: 100,
        // padding: const EdgeInsets.all(10),
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(10),
        //   color: MyColors.gray,
        // ),
        tileColor: MyColors.gray,
        minTileHeight: 100,
        minLeadingWidth: 100,
        visualDensity: VisualDensity.comfortable,
        contentPadding: const EdgeInsets.all(10),

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: CachedNetworkImage(
            imageUrl: "https://i.ibb.co/syL2vn2/unnamed.jpg",
            placeholder: (context, url) =>
                MyProgressIndicator(color: MyColors.lightYellow),
            errorWidget: (context, url, error) => Icon(
              Icons.error,
              color: MyColors.beige,
              size: 30,
            ),
          ),
        ),
        title: Text(
          weddingVenue.name,
          style: TextStyle(
            color: MyColors.lightYellow,
            fontSize: 22,
          ),
        ),
      ),
    );
  }
}
