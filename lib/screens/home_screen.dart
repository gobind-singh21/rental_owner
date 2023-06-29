import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rental_owner/global/current_owner_data.dart';
import 'package:rental_owner/global/dimensions.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rental_owner/screens/product_screens/add_product_screens/add_product_screen.dart';
import 'package:rental_owner/screens/product_screens/show_all_product_screen/show_all_products.dart';
import 'package:rental_owner/screens/profile_screen.dart';
import 'package:rental_owner/global/global.dart';
import 'package:rental_owner/screens/revenue_screens/total_revenue_screen.dart';
import '../utils/data_fetch.dart';

double height = Dimensions.screenHeight;
double width = Dimensions.screenWidth;
double todayRevenue = 0.0;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future calculateTodayRevenue() async {
    final DateTime now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    for(var product in OwnerData.productUID) {
      final List<dynamic> history = (await GetData.fetchProduct(product))['history'];
      for(var orderID in history) {
        final Map<String, dynamic> orderInfo = await GetData.fetchOrderInfo(orderID);
        if(orderInfo['endTimeStamp'] != null) {
          DateTime endTime = DateTime.fromMicrosecondsSinceEpoch(orderInfo['endTimeStamp']);
          DateTime endDate = DateTime(endTime.year, endTime.month, endTime.day);
          if(today == endDate) {
            todayRevenue += orderInfo['pricePaid'];
          }
        }
      }
    }
  }

  Future asyncMethod() async {
    profileImagePath =
        'owners/${currentFirebaseUser!.uid}/profile_images/profile.jpg';
    if (!OwnerData.ownerDataSet) {
      await OwnerData.setOwnerData();
    }
    await calculateTodayRevenue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AddProductScreen())),
        child: Container(
          height: Dimensions.screenHeight / 15,
          width: Dimensions.screenHeight / 15,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
          ),
          child: const Icon(
            Icons.add_rounded,
            size: 40,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: Dimensions.screenHeight / 2.5,
            width: width,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(50)),
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.secondary,
                  Theme.of(context).colorScheme.primary,
                ],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 60,
                left: 40,
                right: 40,
                bottom: 60,
              ),
              child: FutureBuilder(
                future: asyncMethod(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    Fluttertoast.showToast(msg: 'Error occurred try again later!');
                    return Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.error_rounded,
                            color: Theme.of(context).colorScheme.error,
                            size: 50,
                          ),
                          SizedBox(
                            height: height / 80,
                          ),
                          Text(
                            'Error occurred try again later...',
                            style: TextStyle(
                              fontSize: 35,
                              color: Theme.of(context).textTheme.bodyLarge!.color,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Hello ${OwnerData.name}',
                              style: TextStyle(
                                color: Theme.of(context).textTheme.displayMedium!.color,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Expanded(
                              child: SizedBox(),
                            ),
                            InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfileScreen(),
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Theme.of(context).colorScheme.secondary,
                                    width: 3,
                                  ),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    OwnerData.profileImageURL,
                                    height: height / 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height / 10,
                        ),
                        const Text(
                          "Today's revenue",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "\u{20B9} $todayRevenue",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 40.0,
              left: 20,
              right: 20,
              bottom: 10,
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  height: Dimensions.screenHeight / 5,
                  width: Dimensions.screenHeight / 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).cardColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue.shade600,
                              Colors.blue.shade300,
                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 22,
                          backgroundColor: Colors.transparent,
                          child: Icon(
                            Icons.people_rounded,
                            color: Theme.of(context).iconTheme.color,
                            // color: Colors.black,
                          ),
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      Row(
                        children: [
                          Text(
                            "Customers",
                            style: TextStyle(
                              color: Theme.of(context).textTheme.bodyLarge?.color,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          const Icon(Icons.chevron_right_rounded)
                        ],
                      ),
                    ],
                  ),
                ),
                const Expanded(child: SizedBox()),
                InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ShowAllProducts(),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    height: Dimensions.screenHeight / 5,
                    width: Dimensions.screenHeight / 5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).cardColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                Colors.yellow.shade800,
                                Colors.yellow.shade600,
                              ],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 23,
                            backgroundColor: Colors.transparent,
                            child: Icon(
                              FontAwesomeIcons.box,
                              color: Theme.of(context).iconTheme.color,
                            ),
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                        Row(
                          children: [
                            Text(
                              "Products",
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodyLarge?.color,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Expanded(child: SizedBox()),
                            const Icon(Icons.chevron_right_rounded)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
              left: 20,
              right: 20,
              bottom: 10,
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  height: Dimensions.screenHeight / 5,
                  width: Dimensions.screenHeight / 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).cardColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              Colors.red.shade500,
                              Colors.red.shade300,
                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 22,
                          backgroundColor: Colors.transparent,
                          child: Icon(
                            Icons.insert_chart_rounded,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      Row(
                        children: [
                          Text(
                            "Statistics",
                            style: TextStyle(
                              color: Theme.of(context).textTheme.bodyLarge?.color,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          const Icon(Icons.chevron_right_rounded)
                        ],
                      ),
                    ],
                  ),
                ),
                const Expanded(child: SizedBox()),
                InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TotalRevenueScreen(),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    height: Dimensions.screenHeight / 5,
                    width: Dimensions.screenHeight / 5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).cardColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                Colors.green.shade500,
                                Colors.green.shade300,
                              ],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 22,
                            backgroundColor: Colors.transparent,
                            child: Icon(
                              Icons.currency_rupee_rounded,
                              color: Theme.of(context).iconTheme.color,
                            ),
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                        Row(
                          children: [
                            Text(
                              "Net revenue",
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodyLarge!.color,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Expanded(child: SizedBox()),
                            const Icon(Icons.chevron_right_rounded)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}