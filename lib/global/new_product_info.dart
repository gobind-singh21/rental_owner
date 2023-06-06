import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rental_owner/global/global.dart';

class NewProductInfo {
  static String name = "";
  static double pricePerHour = 0.0;
  static List<String> productImageURLs = [];
  static String ownerID = "";
  static List<String> description = [];

  static uploadNewProductInfo({required String productID}) async {
    final CollectionReference collectionRef = db.collection('products');
    await collectionRef.doc(productID).set({
      'name': name,
      'pricePerHour': pricePerHour,
      'productImageURLs': FieldValue.arrayUnion(productImageURLs),
      'ownerID': ownerID,
      'description': FieldValue.arrayUnion(description),
    });
    final ownerDocRef = db.collection('owners').doc(currentFirebaseUser!.uid);
    final doc = await ownerDocRef.get();
    final dataMap = doc.data() as Map<String, dynamic>;
    // final dataMap = await ownerRef.doc(currentFirebaseUser!.uid).get();
    final List<dynamic> productUIDs = dataMap['productUIDs'];
    productUIDs.add(productID);
    ownerDocRef.update({'productUIDs': productUIDs});
  }
}
