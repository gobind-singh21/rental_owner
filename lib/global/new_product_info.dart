import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rental_owner/global/current_Owner_data.dart';
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
      'rating': 0.0,
      'numberOfReviews': 0,
      'history': FieldValue.arrayUnion([]),
      'top': false,
      'totalRevenue': 0.0
    });
    final ownerDocRef = db.collection('owners').doc(currentFirebaseUser!.uid);
    OwnerData.productUID.add(productID);
    await ownerDocRef.update({'productUIDs': FieldValue.arrayUnion(OwnerData.productUID)});
  }
}
