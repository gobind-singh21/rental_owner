import 'package:rental_owner/global/global.dart';

class GetData {
  static Future<Map<String, dynamic>> fetchProduct(dynamic productID) async {
    final productDocRef = db.collection('products').doc(productID);
    final productDoc = await productDocRef.get();
    final Map<String, dynamic> productData = productDoc.data() as Map<String, dynamic>;
    return productData;
  }

  static Future<Map<String, dynamic>> fetchOrderInfo(dynamic orderID) async {
    final orderDocRef = db.collection('orders').doc(orderID);
    final orderDoc = await orderDocRef.get();
    final Map<String, dynamic> orderData = orderDoc.data() as Map<String, dynamic>;
    return orderData;
  }

  static Future<List<dynamic>> fetchProducts() async {
    final ownerDocRef = db.collection('owners').doc(currentFirebaseUser!.uid);
    final ownerDoc = await ownerDocRef.get();
    final Map<String, dynamic> ownerData = ownerDoc.data() as Map<String, dynamic>;
    return ownerData['productUIDs'];
  }

  static Future<Map<String, dynamic>> fetchOwnerInfo() async {
    final ownerDocRef = db.collection('owners').doc(currentFirebaseUser!.uid);
    final ownerDoc = await ownerDocRef.get();
    final Map<String, dynamic> ownerData = ownerDoc.data() as Map<String, dynamic>;
    return ownerData;
  }
}