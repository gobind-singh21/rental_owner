import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rental_owner/app_widgets/text_widgets/heading_text.dart';
import 'package:rental_owner/app_widgets/text_widgets/normal_text.dart';
import 'package:rental_owner/global/dimensions.dart';
import 'package:rental_owner/utils/data_fetch.dart';

double height = Dimensions.screenHeight;
double width = Dimensions.screenWidth;

class RecentOrdersScreen extends StatelessWidget {
  const RecentOrdersScreen({super.key});

  Future<List<Map<String, dynamic>>> orderAndProductInfo(
      dynamic orderID) async {
    final orderData = await GetData.fetchOrderInfo(orderID);
    final productData = await GetData.fetchProduct(orderData['productID']);

    return [orderData, productData];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left_rounded,
            size: 35,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: FutureBuilder(
        future: GetData.fetchAllOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator.adaptive();
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
            List<dynamic>? orders = snapshot.data;
            if (orders == null) return Container();
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) => FutureBuilder(
                future: orderAndProductInfo(orders[index]),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return Container();
                  else if (snapshot.hasError) {
                    Fluttertoast.showToast(
                      msg: 'Error occurred try again later!',
                    );
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
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    List<Map<String, dynamic>>? orderData = snapshot.data;
                    if (orderData == null) return Container();
                    return Order(
                      orderInfo: orderData[0],
                      productInfo: orderData[1],
                    );
                  }
                },
              ),
            );
          }
        },
      ),
    );
  }
}

class Order extends StatelessWidget {
  final Map<String, dynamic> productInfo;
  final Map<String, dynamic> orderInfo;
  const Order({super.key, required this.orderInfo, required this.productInfo});

  @override
  Widget build(BuildContext context) {
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
              color: Theme.of(context).cardColor,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(height / 43.85),
                bottomLeft: Radius.circular(height / 43.85),
              ),
              child: Image.network(productInfo['productImageURLs'].first),
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
                  top: height / 87.7,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        HeadingText(
                          productInfo['name'],
                          15,
                          TextOverflow.ellipsis,
                          Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Icon(
                          Icons.verified_rounded,
                          size: width / 27.4,
                          color: Colors.blue,
                        )
                      ],
                    ),
                    NormalText(
                      'Time period: ${productInfo['startTimeStamp'].difference(productInfo['endTimeStamp'])}',
                      13,
                      TextOverflow.ellipsis,
                      Colors.grey,
                    ),
                    SizedBox(
                      height: height / 95,
                    ),
                    Text(
                      "\u{20B9}${productInfo['pricePerHour']} / hr",
                      style: TextStyle(
                        fontSize: 17,
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
