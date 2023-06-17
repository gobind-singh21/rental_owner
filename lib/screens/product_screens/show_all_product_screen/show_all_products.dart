import 'package:flutter/material.dart';
import 'package:rental_owner/app_widgets/list_item.dart';
import 'package:rental_owner/app_widgets/text_widgets/heading_text.dart';
import 'package:rental_owner/global/current_owner_data.dart';
import 'package:rental_owner/global/dimensions.dart';
import 'package:rental_owner/utils/data_fetch.dart';

double height = Dimensions.screenHeight;

class ShowAllProducts extends StatelessWidget {
  const ShowAllProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left_rounded,
            size: 35,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: const HeadingText('All products', 25, null, Colors.black),
      ),
      body: SizedBox(
        height: height,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return FutureBuilder(
              future: GetData.fetchProduct(OwnerData.productUID[index]),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox();
                }
                if (snapshot.hasError) {
                  return const Text("Error occurred in loading data");
                }
                if (snapshot.hasData) {
                  Map<String, dynamic> map =
                      snapshot.data as Map<String, dynamic>;
                  return ListItem(map: map);
                }
                return const Text("Error in loading data.");
              },
            );
          },
          itemCount: OwnerData.productUID.length,
        ),
      ),
    );
  }
}
