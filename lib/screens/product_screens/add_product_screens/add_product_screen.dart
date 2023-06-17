import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rental_owner/app_widgets/button.dart';
import 'package:rental_owner/app_widgets/text_widgets/heading_text.dart';
import 'package:rental_owner/global/dimensions.dart';
import 'package:rental_owner/global/global.dart';
import 'package:rental_owner/global/new_product_info.dart';
import 'package:rental_owner/screens/product_screens/add_product_screens/add_product_image.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final double height = Dimensions.screenHeight;
  final double width = Dimensions.screenWidth;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _productName = TextEditingController();
  final TextEditingController _productPrice = TextEditingController();

  void moveToNextStep() {
    if (_formKey.currentState!.validate()) {
      NewProductInfo.name = _productName.text.trim();
      NewProductInfo.ownerID = currentFirebaseUser!.uid;
      NewProductInfo.pricePerHour = double.parse(_productPrice.text.trim());
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddProductImage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () => moveToNextStep(),
        child: MyButton('Next', width / 10, height / 10, 10),
      ),
      appBar: AppBar(
        title: const HeadingText('Add product', 20, null, Colors.black),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.chevron_left_rounded,
            size: 35,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: Dimensions.screenHeight / 54.8125,
                horizontal: Dimensions.screenWidth / 12.84375,
              ),
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.name,
                    controller: _productName,
                    decoration: InputDecoration(
                      labelText: 'Product name',
                      hintText: 'Enter product name',
                      labelStyle: TextStyle(
                        fontSize: Dimensions.screenHeight / 54.8125,
                      ),
                      hintStyle: TextStyle(
                        fontSize: Dimensions.screenHeight / 53,
                      ),
                      prefixIcon: Icon(
                        FontAwesomeIcons.box,
                        size: Dimensions.screenHeight / 29.2333,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Product name cannot be empty";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _productPrice,
                    decoration: InputDecoration(
                      labelText: 'Price / hr',
                      hintText: 'Enter Price / hr',
                      labelStyle: TextStyle(
                        fontSize: Dimensions.screenHeight / 54.8125,
                      ),
                      hintStyle: TextStyle(
                        fontSize: Dimensions.screenHeight / 53,
                      ),
                      prefixIcon: Icon(
                        Icons.currency_rupee_rounded,
                        size: Dimensions.screenHeight / 29.2333,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Price should have some value";
                      } else if (!value.isNum) {
                        return "Price should be a numeric value";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
