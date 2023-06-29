import 'package:flutter/material.dart';
import 'package:rental_owner/global/dimensions.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rental_owner/app_widgets/text_widgets/heading_text.dart';
import 'package:rental_owner/app_widgets/text_widgets/normal_text.dart';

class ListItem extends StatelessWidget {
  final Map<String, dynamic> map;
  ListItem({super.key, required this.map});

  final double height = Dimensions.screenHeight;
  final double width = Dimensions.screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, top: 10, left: 15, right: 15),
      child: Row(
        children: [
          Container(
            width: width / 3.425,
            height: width / 3.425,
            decoration: BoxDecoration(
              // boxShadow: const [
              //   BoxShadow(
              //     color: Color.fromARGB(108, 93, 93, 93),
              //     offset: Offset(1, 5),
              //     blurRadius: 4,
              //   ),
              // ],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(height / 43.85),
                bottomLeft: Radius.circular(height / 43.85),
              ),
              color: Colors.white,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(height / 43.85),
                bottomLeft: Radius.circular(height / 43.85),
              ),
              child: Image.network(
                map['productImageURLs'].first,
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: width / 3.425,
              width: width / 2.055,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(height / 43.85),
                  bottomRight: Radius.circular(height / 43.85),
                ),
                color: Theme.of(context).cardColor,
                // boxShadow: const [
                //   BoxShadow(
                //     color: Color.fromARGB(108, 93, 93, 93),
                //     offset: Offset(1, 5),
                //     blurRadius: 4,
                //   )
                // ],
              ),
              child: Padding(
                padding: EdgeInsets.all(height / 87.7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        HeadingText(
                          map['name'],
                          15,
                          TextOverflow.ellipsis,
                          Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Icon(
                          Icons.verified,
                          size: width / 27.4,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        RatingBarIndicator(
                          rating: map['rating'] / 10,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: width / 27.4,
                          direction: Axis.horizontal,
                        ),
                        NormalText(
                          ":${map['rating']} (${map['numberOfReviews'].toString()}) Reviews",
                          13,
                          null,
                          Colors.grey,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height / 95,
                    ),
                    Text(
                      "\u{20B9}${map['pricePerHour']} / hr",
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
