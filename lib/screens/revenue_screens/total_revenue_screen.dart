import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rental_owner/app_widgets/text_widgets/heading_text.dart';
import 'package:rental_owner/global/dimensions.dart';
import 'package:rental_owner/global/current_owner_data.dart';
import '../../utils/data_fetch.dart';
import '../../app_widgets/text_widgets/normal_text.dart';

List<dynamic> productIDs = [];
double height = Dimensions.screenHeight;
double width = Dimensions.screenWidth;
double netRevenue = 0.0;

class TotalRevenueScreen extends StatelessWidget {
  const TotalRevenueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left_rounded,
            size: 35,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: HeadingText(
          'Total Revenue',
          20,
          null,
          Theme.of(context).textTheme.bodyLarge!.color,
        ),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: OwnerData.productUID.length,
        itemBuilder: (context, index) {
          return FutureBuilder(
            future: GetData.fetchProduct(OwnerData.productUID[index]),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return const Text("Error occurred! Try again later...");
              }
              final prodData = snapshot.data;
              if (prodData == null) {
                return Container();
              }
              return Container(
                margin: const EdgeInsets.only(
                  bottom: 10,
                  top: 10,
                  left: 15,
                  right: 15,
                ),
                child: Row(
                  children: [
                    Container(
                      width: width / 3.425,
                      height: width / 3.425,
                      decoration: BoxDecoration(
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
                          prodData['productImageURLs'].first,
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
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            // left: height / 87.7,
                            // right: height / 87.7,
                            top: height / 87.7,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  HeadingText(
                                    prodData['name'],
                                    15,
                                    TextOverflow.ellipsis,
                                    Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color,
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
                                    rating: prodData['rating'] / 10,
                                    itemBuilder: (context, index) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    itemCount: 5,
                                    itemSize: width / 27.4,
                                    direction: Axis.horizontal,
                                  ),
                                  NormalText(
                                    ":${prodData['rating'] / 10} (${prodData['numberOfReviews']}) Reviews",
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
                                "\u{20B9}${prodData['pricePerHour']} / hr",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  width: width,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                      Theme.of(context).colorScheme.primary,
                                      Theme.of(context).colorScheme.secondary,
                                    ]),
                                    // color: Colors.blue.shade400,
                                    borderRadius: BorderRadius.only(
                                      bottomRight:
                                          Radius.circular(height / 43.85),
                                    ),
                                  ),
                                  child: Text(
                                    'Total Revenue : ${prodData['totalRevenue']}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .textTheme
                                          .displayMedium!
                                          .color,
                                    ),
                                  ),
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
            },
          );
        },
      ),
    );
  }
}
