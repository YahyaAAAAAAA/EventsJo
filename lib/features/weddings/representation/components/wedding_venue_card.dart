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
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          //* image
          Container(
            height: 110,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: MyColors.white,
                borderRadius: BorderRadius.circular(5),
                //dev might change later
                boxShadow: [
                  BoxShadow(
                    color: Colors.red.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(2, 2),
                  ),
                  BoxShadow(
                    color: Colors.red.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(-2, -2),
                  ),
                ]),
            // width: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              //display preview image
              child: CachedNetworkImage(
                imageUrl: weddingVenue.pics[0],
                //waiting for image
                placeholder: (context, url) => SizedBox(
                  width: 100,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: MyProgressIndicator(color: MyColors.black),
                  ),
                ),
                //error getting image
                errorWidget: (context, url, error) => SizedBox(
                  width: 100,
                  child: Icon(
                    Icons.error_outline,
                    color: MyColors.black,
                    size: 40,
                  ),
                ),
                fit: BoxFit.scaleDown,
              ),
            ),
          ),

          //* details
          Expanded(
            child: Container(
              height: 100,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: MyColors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //* title
                  Text(
                    weddingVenue.name,
                    style: TextStyle(
                      color: MyColors.black,
                      fontSize: 22,
                    ),
                  ),
                  //* available or not
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: weddingVenue.isOpen
                            ? MyColors.greenShade3
                            : MyColors.redShade3,
                        size: 16,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        weddingVenue.isOpen ? "Available" : "Full",
                        style: TextStyle(
                          color: MyColors.black,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  //* rating
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: weddingVenue.rate >= 1
                            ? MyColors.fullRate
                            : MyColors.emptyRate,
                        size: 20,
                      ),
                      Icon(
                        Icons.star,
                        color: weddingVenue.rate >= 2
                            ? MyColors.fullRate
                            : MyColors.emptyRate,
                        size: 20,
                      ),
                      Icon(
                        Icons.star,
                        color: weddingVenue.rate >= 3
                            ? MyColors.fullRate
                            : MyColors.emptyRate,
                        size: 20,
                      ),
                      Icon(
                        Icons.star,
                        color: weddingVenue.rate >= 4
                            ? MyColors.fullRate
                            : MyColors.emptyRate,
                        size: 20,
                      ),
                      Icon(
                        Icons.star,
                        color: weddingVenue.rate >= 5
                            ? MyColors.fullRate
                            : MyColors.emptyRate,
                        size: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          //* button
          Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              color: MyColors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: TextButton(
                onPressed: () {},
                style: ButtonStyle(
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  backgroundColor: WidgetStatePropertyAll(MyColors.red),
                ),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: MyColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
