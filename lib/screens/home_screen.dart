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
      backgroundColor: Colors.grey.shade100,
      floatingActionButton: InkWell(
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AddProductScreen())),
        child: Container(
          height: Dimensions.screenHeight / 15,
          width: Dimensions.screenHeight / 15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.screenWidth),
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 0, 100, 255),
                Colors.blue,
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          child: const Icon(
            Icons.add_rounded,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: Dimensions.screenHeight / 2.5,
            width: width,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50)),
              gradient: LinearGradient(
                colors: [
                  Colors.blue,
                  Color.fromARGB(255, 0, 0, 255),
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
                          const Icon(
                            Icons.error_rounded,
                            color: Colors.grey,
                            size: 50,
                          ),
                          SizedBox(
                            height: height / 80,
                          ),
                          const Text(
                            'Error occurred try again later...',
                            style: TextStyle(
                              fontSize: 35,
                              color: Colors.black,
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
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
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
                                    color: Colors.blue.shade300,
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
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue,
                              Colors.blue.shade200,
                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                          ),
                        ),
                        child: const CircleAvatar(
                          radius: 22,
                          backgroundColor: Colors.transparent,
                          child: Icon(
                            Icons.people_rounded,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      const Row(
                        children: [
                          Text(
                            "Customers",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(child: SizedBox()),
                          Icon(Icons.chevron_right_rounded)
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
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                const Color.fromARGB(255, 255, 230, 0),
                                Colors.yellow.shade100,
                              ],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                            ),
                          ),
                          child: const CircleAvatar(
                            radius: 23,
                            backgroundColor: Colors.transparent,
                            child: Icon(
                              FontAwesomeIcons.box,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                        const Row(
                          children: [
                            Text(
                              "Products",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Expanded(child: SizedBox()),
                            Icon(Icons.chevron_right_rounded)
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
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              Colors.redAccent,
                              Color.fromARGB(255, 255, 205, 200),
                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                          ),
                        ),
                        child: const CircleAvatar(
                          radius: 22,
                          backgroundColor: Colors.transparent,
                          child: Icon(
                            Icons.insert_chart_rounded,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      const Row(
                        children: [
                          Text(
                            "Statistics",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(child: SizedBox()),
                          Icon(Icons.chevron_right_rounded)
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
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                Colors.green,
                                Colors.green.shade100,
                              ],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                            ),
                          ),
                          child: const CircleAvatar(
                            radius: 22,
                            backgroundColor: Colors.transparent,
                            child: Icon(
                              Icons.currency_rupee_rounded,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                        const Row(
                          children: [
                            Text(
                              "Net revenue",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Expanded(child: SizedBox()),
                            Icon(Icons.chevron_right_rounded)
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