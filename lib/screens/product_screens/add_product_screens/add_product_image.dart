import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rental_owner/app_widgets/text_widgets/heading_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:rental_owner/app_widgets/button.dart';
import 'package:rental_owner/global/current_owner_data.dart';
import 'package:rental_owner/global/dimensions.dart';
import 'package:rental_owner/global/global.dart';
import 'package:rental_owner/global/new_product_info.dart';
import 'package:rental_owner/screens/home_screen.dart';
import 'dart:io';

import 'package:rental_owner/utils/cropper.dart';

class AddProductImage extends StatefulWidget {
  const AddProductImage({super.key});

  @override
  State<AddProductImage> createState() => _AddProductImageState();
}

class _AddProductImageState extends State<AddProductImage> {
  final TextEditingController _descriptionController = TextEditingController();
  List<File> productImageFiles = [];
  final double height = Dimensions.screenHeight;
  final double width = Dimensions.screenWidth;
  bool imageFilesSelected = false;

  Widget createWidget() {
    if (!imageFilesSelected) {
      return Container(
        height: height / 3.5,
        width: width,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.image_not_supported,
              size: 50,
              color: Theme.of(context).iconTheme.color,
            ),
            const SizedBox(height: 10),
            HeadingText('No image added', 20, null, Theme.of(context).textTheme.bodyLarge!.color),
          ],
        ),
      );
    }

    return SizedBox(
      height: height / 3.5,
      width: width,
      child: PageView.builder(
        itemBuilder: (context, index) {
          return Container(
            width: width / 3,
            margin: const EdgeInsets.symmetric(horizontal: 80, vertical: 0),
            // padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                )
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.file(
                productImageFiles[index],
                fit: BoxFit.contain,
              ),
            ),
          );
        },
        itemCount: productImageFiles.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Future pickMultipleFiles() async {
    List<String> filePaths = [];
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.image,
      );
      if (result != null) {
        filePaths = result.paths.map((path) => path!).toList();
      }
    } catch (e) {
      Fluttertoast.showToast(msg: '$e');
    }
    for (var imagePath in filePaths) {
      File image = await Cropper.cropSquareImage(File(imagePath));
      productImageFiles.add(image);
    }
    if (productImageFiles.isNotEmpty) {
      imageFilesSelected = true;
      // print(productImageFiles.length);
      setState(() {});
    } else {
      Fluttertoast.showToast(msg: 'Please select files and crop it');
    }
    return;
  }

  Future uploadInfo() async {
    List<String> downloadURLs = [];
    String directoryAddress =
        "owners/${currentFirebaseUser!.uid}/product_images";
    for (var imageFile in productImageFiles) {
      final String fileName =
          '${DateTime.now().millisecondsSinceEpoch}_${imageFile.path.split('/').last}';
      Reference storageRef =
          FirebaseStorage.instance.ref().child('$directoryAddress/$fileName');
      TaskSnapshot uploadTask = await storageRef.putFile(imageFile);
      final String downloadURL = await uploadTask.ref.getDownloadURL();
      downloadURLs.add(downloadURL);
    }
    final String productID = "${DateTime.now().microsecondsSinceEpoch}";
    OwnerData.productUID.add(productID);
    NewProductInfo.description = _descriptionController.text.trim().split('\n');
    NewProductInfo.productImageURLs = downloadURLs;
    NewProductInfo.ownerID = currentFirebaseUser!.uid;
    NewProductInfo.uploadNewProductInfo(productID: productID);
    Fluttertoast.showToast(msg: 'Product added successfully');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () {
          uploadInfo();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
            ModalRoute.withName('name'),
          );
        },
        child: MyButton('Finish', width / 10, height / 10, 10),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left_rounded,
            size: 35,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      // extendBodyBehindAppBar: true,
      body: Column(
        children: [
          createWidget(),
          SizedBox(
            height: height / 80,
          ),
          InkWell(
            onTap: () {
              pickMultipleFiles();
              // print(productImageFiles.length);
              setState(() {});
            },
            child: MyButton('Select files', height / 20, height / 7, 10),
          ),
          SizedBox(
            height: height / 80,
          ),
          HeadingText(
            'Enter product description',
            20,
            null,
            Theme.of(context).textTheme.bodyLarge!.color,
          ),
          SizedBox(
            height: height / 80,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 10,
              ),
              child: TextFormField(
                controller: _descriptionController,
                maxLines: null,
                minLines: 1,
                // expands: true,
              ),
            ),
          )
        ],
      ),
    );
  }
}
