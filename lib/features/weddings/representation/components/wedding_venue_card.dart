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
  //TODO MAKE NEW CARD DESIGN FIRST THING TMRO
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          //* image
          SizedBox(
            height: 100,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(5), topLeft: Radius.circular(5)),
              child: CachedNetworkImage(
                imageUrl: "https://i.ibb.co/syL2vn2/unnamed.jpg",
                placeholder: (context, url) =>
                    MyProgressIndicator(color: MyColors.lightYellow),
                errorWidget: (context, url, error) => Icon(
                  Icons.error,
                  color: MyColors.beige,
                  size: 30,
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
                color: MyColors.gray,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //* title
                  Text(
                    weddingVenue.name,
                    style: TextStyle(
                      color: MyColors.lightYellow,
                      fontSize: 22,
                    ),
                  ),
                  //* available or not
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: MyColors.green,
                        size: 16,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "Available",
                        style: TextStyle(
                          color: MyColors.lightYellow,
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
                        color: MyColors.lightYellow,
                        size: 20,
                      ),
                      Icon(
                        Icons.star,
                        color: MyColors.lightYellow,
                        size: 20,
                      ),
                      Icon(
                        Icons.star,
                        color: MyColors.lightYellow,
                        size: 20,
                      ),
                      Icon(
                        Icons.star,
                        color: MyColors.gray2,
                        size: 20,
                      ),
                      Icon(
                        Icons.star,
                        color: MyColors.gray2,
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
              color: MyColors.gray,
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
                  overlayColor: WidgetStatePropertyAll(MyColors.gray2),
                  backgroundColor: WidgetStatePropertyAll(MyColors.black),
                ),
                child: Icon(
                  Icons.arrow_forward,
                  color: MyColors.lightYellow,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
